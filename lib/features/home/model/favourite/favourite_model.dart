class FavouriteModel {
  String? status;
  int? count;
  List<Data>? data;

  FavouriteModel({this.status, this.count, this.data});

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    count = json['count'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['count'] = count;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? sold;
  List<String>? images;
  List<Subcategory>? subcategory;
  int? ratingsQuantity;
  String? sId;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  dynamic price;
  dynamic priceAfterDiscount;
  String? imageCover;
  Category? category;
  Category? brand;
  double? ratingsAverage;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? id;

  Data(
      {this.sold,
        this.images,
        this.subcategory,
        this.ratingsQuantity,
        this.sId,
        this.title,
        this.slug,
        this.description,
        this.quantity,
        this.price,
        this.priceAfterDiscount,
        this.imageCover,
        this.category,
        this.brand,
        this.ratingsAverage,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    sold = json['sold'];
    images = json['images'].cast<String>();
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(Subcategory.fromJson(v));
      });
    }
    ratingsQuantity = json['ratingsQuantity'];
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    imageCover = json['imageCover'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    brand = json['brand'] != null ? Category.fromJson(json['brand']) : null;
    ratingsAverage = json['ratingsAverage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sold'] = sold;
    data['images'] = images;
    if (subcategory != null) {
      data['subcategory'] = subcategory!.map((v) => v.toJson()).toList();
    }
    data['ratingsQuantity'] = ratingsQuantity;
    data['_id'] = sId;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['quantity'] = quantity;
    data['price'] = price;
    data['priceAfterDiscount'] = priceAfterDiscount;
    data['imageCover'] = imageCover;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['ratingsAverage'] = ratingsAverage;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['id'] = id;
    return data;
  }
}

class Subcategory {
  String? sId;
  String? name;
  String? slug;
  String? category;

  Subcategory({this.sId, this.name, this.slug, this.category});

  Subcategory.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['category'] = category;
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? slug;
  String? image;

  Category({this.sId, this.name, this.slug, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['slug'] = slug;
    data['image'] = image;
    return data;
  }
}
