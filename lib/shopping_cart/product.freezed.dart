// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Product {
  String get name => throw _privateConstructorUsedError;
  num get price => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String? get imageAssetName => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProductCopyWith<Product> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductCopyWith<$Res> {
  factory $ProductCopyWith(Product value, $Res Function(Product) then) =
      _$ProductCopyWithImpl<$Res, Product>;
  @useResult
  $Res call(
      {String name, num price, String description, String? imageAssetName});
}

/// @nodoc
class _$ProductCopyWithImpl<$Res, $Val extends Product>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? description = null,
    Object? imageAssetName = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageAssetName: freezed == imageAssetName
          ? _value.imageAssetName
          : imageAssetName // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$$_ProductCopyWith(
          _$_Product value, $Res Function(_$_Product) then) =
      __$$_ProductCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, num price, String description, String? imageAssetName});
}

/// @nodoc
class __$$_ProductCopyWithImpl<$Res>
    extends _$ProductCopyWithImpl<$Res, _$_Product>
    implements _$$_ProductCopyWith<$Res> {
  __$$_ProductCopyWithImpl(_$_Product _value, $Res Function(_$_Product) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? price = null,
    Object? description = null,
    Object? imageAssetName = freezed,
  }) {
    return _then(_$_Product(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageAssetName: freezed == imageAssetName
          ? _value.imageAssetName
          : imageAssetName // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_Product implements _Product {
  const _$_Product(
      {required this.name,
      required this.price,
      required this.description,
      this.imageAssetName});

  @override
  final String name;
  @override
  final num price;
  @override
  final String description;
  @override
  final String? imageAssetName;

  @override
  String toString() {
    return 'Product(name: $name, price: $price, description: $description, imageAssetName: $imageAssetName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Product &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageAssetName, imageAssetName) ||
                other.imageAssetName == imageAssetName));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, name, price, description, imageAssetName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      __$$_ProductCopyWithImpl<_$_Product>(this, _$identity);
}

abstract class _Product implements Product {
  const factory _Product(
      {required final String name,
      required final num price,
      required final String description,
      final String? imageAssetName}) = _$_Product;

  @override
  String get name;
  @override
  num get price;
  @override
  String get description;
  @override
  String? get imageAssetName;
  @override
  @JsonKey(ignore: true)
  _$$_ProductCopyWith<_$_Product> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ShoppingCartItem {
  Product get product => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShoppingCartItemCopyWith<ShoppingCartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShoppingCartItemCopyWith<$Res> {
  factory $ShoppingCartItemCopyWith(
          ShoppingCartItem value, $Res Function(ShoppingCartItem) then) =
      _$ShoppingCartItemCopyWithImpl<$Res, ShoppingCartItem>;
  @useResult
  $Res call({Product product, int quantity});

  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class _$ShoppingCartItemCopyWithImpl<$Res, $Val extends ShoppingCartItem>
    implements $ShoppingCartItemCopyWith<$Res> {
  _$ShoppingCartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? quantity = null,
  }) {
    return _then(_value.copyWith(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProductCopyWith<$Res> get product {
    return $ProductCopyWith<$Res>(_value.product, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ShoppingCartItemCopyWith<$Res>
    implements $ShoppingCartItemCopyWith<$Res> {
  factory _$$_ShoppingCartItemCopyWith(
          _$_ShoppingCartItem value, $Res Function(_$_ShoppingCartItem) then) =
      __$$_ShoppingCartItemCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Product product, int quantity});

  @override
  $ProductCopyWith<$Res> get product;
}

/// @nodoc
class __$$_ShoppingCartItemCopyWithImpl<$Res>
    extends _$ShoppingCartItemCopyWithImpl<$Res, _$_ShoppingCartItem>
    implements _$$_ShoppingCartItemCopyWith<$Res> {
  __$$_ShoppingCartItemCopyWithImpl(
      _$_ShoppingCartItem _value, $Res Function(_$_ShoppingCartItem) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? product = null,
    Object? quantity = null,
  }) {
    return _then(_$_ShoppingCartItem(
      product: null == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Product,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_ShoppingCartItem implements _ShoppingCartItem {
  const _$_ShoppingCartItem({required this.product, required this.quantity});

  @override
  final Product product;
  @override
  final int quantity;

  @override
  String toString() {
    return 'ShoppingCartItem(product: $product, quantity: $quantity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShoppingCartItem &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @override
  int get hashCode => Object.hash(runtimeType, product, quantity);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShoppingCartItemCopyWith<_$_ShoppingCartItem> get copyWith =>
      __$$_ShoppingCartItemCopyWithImpl<_$_ShoppingCartItem>(this, _$identity);
}

abstract class _ShoppingCartItem implements ShoppingCartItem {
  const factory _ShoppingCartItem(
      {required final Product product,
      required final int quantity}) = _$_ShoppingCartItem;

  @override
  Product get product;
  @override
  int get quantity;
  @override
  @JsonKey(ignore: true)
  _$$_ShoppingCartItemCopyWith<_$_ShoppingCartItem> get copyWith =>
      throw _privateConstructorUsedError;
}
