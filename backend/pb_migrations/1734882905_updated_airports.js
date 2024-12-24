/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_777299321")

  // remove field
  collection.fields.removeById("text2499937429")

  // remove field
  collection.fields.removeById("text999795048")

  // add field
  collection.fields.addAt(12, new Field({
    "hidden": false,
    "id": "number2499937429",
    "max": null,
    "min": null,
    "name": "lat",
    "onlyInt": false,
    "presentable": false,
    "required": false,
    "system": false,
    "type": "number"
  }))

  // add field
  collection.fields.addAt(13, new Field({
    "hidden": false,
    "id": "number999795048",
    "max": null,
    "min": null,
    "name": "long",
    "onlyInt": false,
    "presentable": false,
    "required": false,
    "system": false,
    "type": "number"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_777299321")

  // add field
  collection.fields.addAt(11, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text2499937429",
    "max": 0,
    "min": 0,
    "name": "lat",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // add field
  collection.fields.addAt(12, new Field({
    "autogeneratePattern": "",
    "hidden": false,
    "id": "text999795048",
    "max": 0,
    "min": 0,
    "name": "long",
    "pattern": "",
    "presentable": false,
    "primaryKey": false,
    "required": false,
    "system": false,
    "type": "text"
  }))

  // remove field
  collection.fields.removeById("number2499937429")

  // remove field
  collection.fields.removeById("number999795048")

  return app.save(collection)
})
