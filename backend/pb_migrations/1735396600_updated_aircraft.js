/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_1402421040")

  // add field
  collection.fields.addAt(1, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text2221813596",
    "max": 0,
    "min": 0,
    "name": "aircraft_id",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(2, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text1667763765",
    "max": 0,
    "min": 0,
    "name": "reg",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(3, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text1338260300",
    "max": 0,
    "min": 0,
    "name": "hex_icao",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(4, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text1514282111",
    "max": 0,
    "min": 0,
    "name": "model_code",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(5, new Field({
    "hidden": false,
    "id": "number2704281778",
    "max": null,
    "min": null,
    "name": "age",
    "onlyInt": false,
    "presentable": false,
    "required": false,
    "system": false,
    "type": "number"
  }))

  // add field
  collection.fields.addAt(6, new Field({
    "hidden": false,
    "id": "date3042273247",
    "max": "",
    "min": "",
    "name": "first_flight_date",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "date"
  }))

  // add field
  collection.fields.addAt(7, new Field({
    "hidden": false,
    "id": "date2063794144",
    "max": "",
    "min": "",
    "name": "delivery_date",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "date"
  }))

  // add field
  collection.fields.addAt(8, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text2301410062",
    "max": 0,
    "min": 0,
    "name": "type_name",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(9, new Field({
    "hidden": false,
    "id": "bool4134605085",
    "name": "is_freighter",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "bool"
  }))

  // add field
  collection.fields.addAt(10, new Field({
    "hidden": false,
    "id": "file3309110367",
    "maxSelect": 1,
    "maxSize": 0,
    "mimeTypes": [],
    "name": "image",
    "presentable": false,
    "protected": false,
    "required": false,
    "system": false,
    "thumbs": [],
    "type": "file"
  }))

  // add field
  collection.fields.addAt(11, new Field({
    "hidden": false,
    "id": "json1407078887",
    "maxSize": 0,
    "name": "registrations",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "json"
  }))

  // add field
  collection.fields.addAt(12, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text3344035145",
    "max": 0,
    "min": 0,
    "name": "attribution",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_1402421040")

  // remove field
  collection.fields.removeById("text2221813596")

  // remove field
  collection.fields.removeById("text1667763765")

  // remove field
  collection.fields.removeById("text1338260300")

  // remove field
  collection.fields.removeById("text1514282111")

  // remove field
  collection.fields.removeById("number2704281778")

  // remove field
  collection.fields.removeById("date3042273247")

  // remove field
  collection.fields.removeById("date2063794144")

  // remove field
  collection.fields.removeById("text2301410062")

  // remove field
  collection.fields.removeById("bool4134605085")

  // remove field
  collection.fields.removeById("file3309110367")

  // remove field
  collection.fields.removeById("json1407078887")

  // remove field
  collection.fields.removeById("text3344035145")

  return app.save(collection)
})
