/// <reference path="../pb_data/types.d.ts" />
migrate((app) => {
  const collection = app.findCollectionByNameOrId("pbc_4114914112")

  // add field
  collection.fields.addAt(9, new Field({
    "hidden": false,
    "id": "json1129633261",
    "maxSize": 0,
    "name": "greatCircleDistance",
    "presentable": false,
    "required": false,
    "system": false,
    "type": "json"
  }))

  return app.save(collection)
}, (app) => {
  const collection = app.findCollectionByNameOrId("pbc_4114914112")

  // remove field
  collection.fields.removeById("json1129633261")

  return app.save(collection)
})
