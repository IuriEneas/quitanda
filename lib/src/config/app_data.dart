import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/models/user_model.dart';
import '../models/cart_item_model.dart';
import '../models/order_model.dart';

ItemModel apple = ItemModel(
  description:
      'A melhor maçã da região e conta com o melhor preço de qualquer quitanda ',
  img: 'assets/fruits/apple.png',
  name: 'Maçã',
  unit: 'kg',
  price: 5.5,
);

ItemModel grape = ItemModel(
  description:
      'A melhor uva da região e conta com o melhor preço de qualquer quitanda ',
  img: 'assets/fruits/grape.png',
  name: 'Uva',
  unit: 'un',
  price: 3.5,
);

ItemModel guava = ItemModel(
  description:
      'A melhor goiaba da região e conta com o melhor preço de qualquer quitanda ',
  img: 'assets/fruits/guava.png',
  name: 'Goiaba',
  unit: 'kg',
  price: 6.99,
);

ItemModel kiwi = ItemModel(
  description:
      'O melhor kiwi da região e conta com o melhor preço de qualquer quitanda ',
  img: 'assets/fruits/kiwi.png',
  name: 'Kiwi',
  unit: 'un',
  price: 15.5,
);

ItemModel mango = ItemModel(
  description:
      'A melhor manga da região e conta com o melhor preço de qualquer quitanda ',
  img: 'assets/fruits/mango.png',
  name: 'Manga',
  unit: 'un',
  price: 2.5,
);

ItemModel papaya = ItemModel(
  description:
      'O melhor mamão da região e conta com o melhor preço de qualquer quitanda ',
  img: 'assets/fruits/papaya.png',
  name: 'Mamão',
  unit: 'kg',
  price: 1.99,
);

List<ItemModel> items = [
  apple,
  grape,
  guava,
  kiwi,
  mango,
  papaya,
];

List<String> categories = [
  'Frutas',
  'Legumes',
  'Carnes',
  'Temperos',
  'Verduras',
  'Cereais',
  'Grãos',
];

List<CartItemModel> cartItems = [
  CartItemModel(
    id: 'asfasfasfa',
    item: apple,
    quantity: 2,
  ),
  CartItemModel(
    id: 'asfasfasfa',
    item: mango,
    quantity: 1,
  ),
  CartItemModel(
    id: 'asfasfasfa',
    item: kiwi,
    quantity: 3,
  ),
];

UserModel user = UserModel(
  fullname: 'Felipe Araújo',
  email: 'fefe@gmail.com',
  phoneNumber: '992415123',
  cpf: '000.000.000-22',
  password: 'mf0as6ey',
);

List<OrderModel> orders = [
  OrderModel(
    id: 'testeid1',
    createDate: DateTime.parse('2023-06-08 10:00:10.465'),
    overdueDate: DateTime.parse('2023-06-08 11:00:10.465'),
    status: 'pending_payment',
    qrCodeImage: '',
    copyAndPaste: 'd12a3fa343t',
    total: 13.5,
    items: [
      CartItemModel(
        id: 'asfasfasfa',
        item: apple,
        quantity: 2,
      ),
      CartItemModel(
        id: 'asfasfasfa',
        item: mango,
        quantity: 1,
      ),
    ],
  ),
  OrderModel(
    id: 'testeid2',
    createDate: DateTime.parse('2023-02-08 10:00:10.465'),
    overdueDate: DateTime.parse('2023-02-08 11:00:10.465'),
    qrCodeImage: '',
    status: 'preparing_purchase',
    copyAndPaste: 'd12a3fa343t',
    total: 11,
    items: [
      CartItemModel(
        id: 'asfasfasfa',
        item: apple,
        quantity: 2,
      ),
    ],
  ),
];
