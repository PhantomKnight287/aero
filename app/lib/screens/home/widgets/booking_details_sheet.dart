import 'package:built_value/json_object.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:openapi/openapi.dart';
import 'package:plane_pal/services/booking_service.dart';
import 'package:plane_pal/widgets/input.dart';

class BookingDetailsSheet extends StatefulWidget {
  final String flightId;
  final FlightBookingEntity? existingBooking;
  final Function()? onSaved;
  final Function()? onDeleted;

  const BookingDetailsSheet({
    super.key,
    required this.flightId,
    this.existingBooking,
    this.onSaved,
    this.onDeleted,
  });

  @override
  State<BookingDetailsSheet> createState() => _BookingDetailsSheetState();
}

class _BookingDetailsSheetState extends State<BookingDetailsSheet> {
  final _formKey = GlobalKey<FormState>();
  final _bookingCodeController = TextEditingController();
  final _seatNumberController = TextEditingController();
  final _notesController = TextEditingController();

  final BookingService _bookingService = BookingService();

  String? _selectedSeatTypeName;
  String? _selectedSeatingClassName;
  String? _selectedReasonName;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.existingBooking != null) {
      _loadExistingBooking();
    } else {
      // Set default reason to personal for new bookings
      _selectedReasonName = 'personal';
    }
  }

  void _loadExistingBooking() {
    final booking = widget.existingBooking!;
    _bookingCodeController.text =
        _extractStringFromJsonObject(booking.bookingCode) ?? '';
    _seatNumberController.text =
        _extractStringFromJsonObject(booking.seatNumber) ?? '';
    _notesController.text = _extractStringFromJsonObject(booking.notes) ?? '';

    // Store enum names as strings to convert later
    if (booking.seatType != null) {
      _selectedSeatTypeName = booking.seatType!.name;
    }
    if (booking.seatingClass != null) {
      _selectedSeatingClassName = booking.seatingClass!.name;
    }
    if (booking.reason != null) {
      _selectedReasonName = booking.reason!.name;
    } else {
      _selectedReasonName = 'personal';
    }
  }

  String? _extractStringFromJsonObject(JsonObject? jsonObject) {
    if (jsonObject == null) return null;
    final value = jsonObject.value;
    if (value is String) return value;
    return value.toString();
  }

  String _formatEnumName(String enumName) {
    return enumName
        .split('_')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }

  Future<void> _saveBooking() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      if (widget.existingBooking != null) {
        // Update existing booking
        final builder = UpdateFlightBookingDTOBuilder();

        // Set string fields - use empty string to clear (backend converts '' to null)
        builder.bookingCode = JsonObject(_bookingCodeController.text);
        builder.seatNumber = JsonObject(_seatNumberController.text);

        // Convert enum names to UpdateFlightBookingDTO enums
        if (_selectedSeatTypeName != null) {
          try {
            builder.seatType = UpdateFlightBookingDTOSeatTypeEnum.valueOf(
                _selectedSeatTypeName!);
          } catch (e) {
            builder.seatType = null;
          }
        } else {
          builder.seatType = null;
        }

        if (_selectedSeatingClassName != null) {
          try {
            builder.seatingClass =
                UpdateFlightBookingDTOSeatingClassEnum.valueOf(
                    _selectedSeatingClassName!);
          } catch (e) {
            builder.seatingClass = null;
          }
        } else {
          builder.seatingClass = null;
        }

        if (_selectedReasonName != null) {
          try {
            builder.reason =
                UpdateFlightBookingDTOReasonEnum.valueOf(_selectedReasonName!);
          } catch (e) {
            builder.reason = null;
          }
        } else {
          builder.reason = null;
        }

        builder.notes = JsonObject(_notesController.text);

        final updateDto = builder.build();

        await _bookingService.updateFlightBooking(
          widget.existingBooking!.id,
          updateDto,
        );
      } else {
        // Create new booking
        CreateFlightBookingDTOSeatTypeEnum? seatTypeEnum;
        CreateFlightBookingDTOSeatingClassEnum? seatingClassEnum;
        CreateFlightBookingDTOReasonEnum reasonEnum =
            CreateFlightBookingDTOReasonEnum.personal;

        if (_selectedSeatTypeName != null) {
          try {
            seatTypeEnum = CreateFlightBookingDTOSeatTypeEnum.valueOf(
                _selectedSeatTypeName!);
          } catch (e) {
            seatTypeEnum = null;
          }
        }

        if (_selectedSeatingClassName != null) {
          try {
            seatingClassEnum = CreateFlightBookingDTOSeatingClassEnum.valueOf(
                _selectedSeatingClassName!);
          } catch (e) {
            seatingClassEnum = null;
          }
        }

        if (_selectedReasonName != null) {
          try {
            reasonEnum =
                CreateFlightBookingDTOReasonEnum.valueOf(_selectedReasonName!);
          } catch (e) {
            reasonEnum = CreateFlightBookingDTOReasonEnum.personal;
          }
        }

        final createDto = CreateFlightBookingDTO((b) => b
          ..flightId = widget.flightId
          ..bookingCode = _bookingCodeController.text.isEmpty
              ? null
              : _bookingCodeController.text
          ..seatNumber = _seatNumberController.text.isEmpty
              ? null
              : _seatNumberController.text
          ..seatType = seatTypeEnum
          ..seatingClass = seatingClassEnum
          ..reason = reasonEnum
          ..notes =
              _notesController.text.isEmpty ? null : _notesController.text);

        await _bookingService.createFlightBooking(createDto);
      }

      if (mounted) {
        widget.onSaved?.call();
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        if (e is ApiException) {
          _errorMessage = e.message;
        } else {
          _errorMessage = 'Failed to save booking: $e';
        }
      });
    }
  }

  Future<void> _deleteBooking() async {
    if (widget.existingBooking == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Booking'),
        content: const Text('Are you sure you want to delete this booking?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _bookingService.deleteFlightBooking(widget.existingBooking!.id);

      if (mounted) {
        widget.onDeleted?.call();
        Navigator.of(context).pop();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        if (e is ApiException) {
          _errorMessage = e.message;
        } else {
          _errorMessage = 'Failed to delete booking: $e';
        }
      });
    }
  }

  @override
  void dispose() {
    _bookingCodeController.dispose();
    _seatNumberController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 16,
            ),
            child: Row(
              children: [
                Text(
                  widget.existingBooking != null
                      ? 'Edit Booking'
                      : 'Add Booking Details',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const Divider(),

          Expanded(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_errorMessage != null) ...[
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red[300]!),
                        ),
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const Gap(16),
                    ],
                    // Booking Code
                    InputField(
                      hintText: 'Booking Code (e.g., ABC123)',
                      keyboardType: TextInputType.text,
                      controller: _bookingCodeController,
                      validator: (value) {
                        if (value != null && value.length > 50) {
                          return 'Booking code must be 50 characters or less';
                        }
                        return null;
                      },
                      fillColor: Colors.grey[50],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    const Gap(16),
                    // Seat Number
                    InputField(
                      hintText: 'Seat Number (e.g., 12A, 1F)',
                      keyboardType: TextInputType.text,
                      controller: _seatNumberController,
                      validator: (value) {
                        if (value != null && value.length > 10) {
                          return 'Seat number must be 10 characters or less';
                        }
                        return null;
                      },
                      fillColor: Colors.grey[50],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    const Gap(16),
                    // Seat Type
                    DropdownButtonFormField<String>(
                      value: _selectedSeatTypeName,
                      decoration: InputDecoration(
                        labelText: 'Seat Type',
                        fillColor: Colors.grey[50],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: CreateFlightBookingDTOSeatTypeEnum.values
                          .map((enumValue) {
                        return DropdownMenuItem(
                          value: enumValue.name,
                          child: Text(_formatEnumName(enumValue.name),style: TextStyle(fontSize: 16,)),
                        );
                      }).toList(),
                      onChanged: _isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _selectedSeatTypeName = value;
                              });
                            },
                    ),
                    const Gap(16),
                    // Seating Class
                    DropdownButtonFormField<String>(
                      value: _selectedSeatingClassName,
                      decoration: InputDecoration(
                        labelText: 'Seating Class',
                        fillColor: Colors.grey[50],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: CreateFlightBookingDTOSeatingClassEnum.values
                          .map((enumValue) {
                        return DropdownMenuItem(
                          value: enumValue.name,
                          child: Text(_formatEnumName(enumValue.name),style: TextStyle(fontSize: 16,)),
                        );
                      }).toList(),
                      onChanged: _isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _selectedSeatingClassName = value;
                              });
                            },
                    ),
                    const Gap(16),
                    // Reason
                    DropdownButtonFormField<String>(
                      value: _selectedReasonName,
                      decoration: InputDecoration(
                        labelText: 'Reason',
                        fillColor: Colors.grey[50],
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                      items: CreateFlightBookingDTOReasonEnum.values
                          .map((enumValue) {
                        return DropdownMenuItem(
                          value: enumValue.name,
                          child: Text(_formatEnumName(enumValue.name),style: TextStyle(fontSize: 16,),),
                        );
                      }).toList(),
                      onChanged: _isLoading
                          ? null
                          : (value) {
                              setState(() {
                                _selectedReasonName = value;
                              });
                            },
                    ),
                    const Gap(16),
                    // Notes
                    InputField(
                      hintText: 'Notes (optional)',
                      keyboardType: TextInputType.multiline,
                      controller: _notesController,
                      maxLines: 4,
                      minLines: 3,
                      validator: (value) {
                        if (value != null && value.length > 500) {
                          return 'Notes must be 500 characters or less';
                        }
                        return null;
                      },
                      fillColor: Colors.grey[50],
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    const Gap(24),
                    // Save Button
                    ElevatedButton(
                      onPressed: _isLoading ? null : _saveBooking,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              widget.existingBooking != null
                                  ? 'Update Booking'
                                  : 'Save Booking',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                    if (widget.existingBooking != null) ...[
                      const Gap(12),
                      // Delete Button
                      OutlinedButton(
                        onPressed: _isLoading ? null : _deleteBooking,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                          side: const BorderSide(color: Colors.red),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(Colors.red),
                                ),
                              )
                            : const Text(
                                'Delete Booking',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
