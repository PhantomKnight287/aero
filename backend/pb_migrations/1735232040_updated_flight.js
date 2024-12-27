/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_4114914112")

  // add field
  collection.fields.addAt(1, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text1231501194",
    "max": 0,
    "min": 0,
    "name": "flight_no",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(2, new Field({
    "hidden": false,
    "id": "json333014825",
    "maxSize": 0,
    "name": "aircraft",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "json"
  }))

  // add field
  collection.fields.addAt(3, new Field({
    "hidden": false,
    "id": "json3960741624",
    "maxSize": 0,
    "name": "airline",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "json"
  }))

  // add field
  collection.fields.addAt(4, new Field({
    "hidden": false,
    "id": "json1541758132",
    "maxSize": 0,
    "name": "arrival",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "json"
  }))

  // add field
  collection.fields.addAt(5, new Field({
    "hidden": false,
    "id": "json1172948593",
    "maxSize": 0,
    "name": "departure",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "json"
  }))

  // add field
  collection.fields.addAt(6, new Field({
    "hidden": false,
    "id": "bool1005475697",
    "name": "cargo",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "bool"
  }))

  // add field
  collection.fields.addAt(7, new Field({
    "hidden": false,
    "id": "date2862495610",
    "max": "",
    "min": "",
    "name": "date",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "date"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_4114914112")

  // remove field
  collection.fields.removeById("text1231501194")

  // remove field
  collection.fields.removeById("json333014825")

  // remove field
  collection.fields.removeById("json3960741624")

  // remove field
  collection.fields.removeById("json1541758132")

  // remove field
  collection.fields.removeById("json1172948593")

  // remove field
  collection.fields.removeById("bool1005475697")

  // remove field
  collection.fields.removeById("date2862495610")

  return app.save(collection)
})
