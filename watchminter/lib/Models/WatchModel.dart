class WatchModel {
  var watchId,
      ownerId,
      images,
  displayImage,
      brand,
      model,
      serialNumber,
      condition,
      papers,
      box,
      location,
      offeredBy,
      history,
      forSale,
      createdAt,
      price;

  WatchModel(
      {this.watchId,
      this.ownerId,
      this.images,
        this.displayImage,
      this.brand,
      this.model,
      this.serialNumber,
      this.condition,
      this.papers,
      this.box,
      this.location,
      this.offeredBy,
      this.history,
      this.forSale,
      this.createdAt,
      this.price});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["watchId"] = watchId;
    map["ownerId"] = ownerId;
    map["brand"] = brand;
    map["model"] = model;
    map["displayImage"]=displayImage;
    map["serialNumber"] = serialNumber;
    map["condition"] = condition;
    map["papers"] = papers;
    map["box"] = box;
    map["location"] = location;
    map["offeredBy"] = offeredBy;
    map["history"] = history;
    map["forSale"] = forSale;
    map["createdAt"] = createdAt;
    map["price"] = price;
    return map;
  }

  factory WatchModel.fromMap(var map) {
    return WatchModel(
      watchId: map['watchId'],
      ownerId: map['ownerId'],
      brand: map['brand'],
      model: map['model'],
      displayImage: map["displayImage"],
      serialNumber: map['serialNumber'],
      condition: map['condition'],
      papers: map['papers'],
      box: map['box'],
      location: map['location'],
      offeredBy: map['offeredBy'],
      history: map['history'],
      forSale: map['forSale'],
      createdAt: map['createdAt'],
      price: map['price'],
    );
  }
}
