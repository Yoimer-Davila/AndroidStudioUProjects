import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u20201b973_eb/database/database.dart';
import 'package:u20201b973_eb/networking/http_helper.dart';
import 'package:u20201b973_eb/ui/preferences_dialog.dart';
import 'package:u20201b973_eb/util/app_preferences.dart';
import 'package:u20201b973_eb/util/converters.dart';
import 'package:u20201b973_eb/util/stylers.dart' as styler;
import 'package:u20201b973_eb/util/navigation.dart' as nav;

class ListProducts extends StatefulWidget {
  final bool fromDatabase;
  const ListProducts({super.key, required this.fromDatabase,});

  @override
  State<ListProducts> createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  AppPreferences preferences = AppPreferences();
  HttpHelper httpHelper = HttpHelper();
  late AppDatabase database;
  List<Product> products = [];
  bool get fromDatabase => widget.fromDatabase;
  PreferencesDialog dialog = PreferencesDialog();
  bool loadedFromDatabase = false;
  TextStyle textStyle = const TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );

  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  void loadProducts() {
    if(!fromDatabase) {
      httpHelper.listProducts().then((value) {
        setState(() {
          products = value;
        });
      });
    }
  }

  void saveProduct(Product product) {
    database.productIsFavorite(product).then((value) {
      if(!value) {
        final copyProduct = product.copyWith(isFavorite: valueOf(true));
        database.insertProduct(copyProduct.toCompanion(true)).then((_) {
          setState(() {
            var index = products.indexOf(product);
            if(index != -1) {
              products[index] = copyProduct;
            }
          });
          preferences.saveForProducts(product.price, product.stock);
        });
      }
    });
  }

  void deleteProduct(Product product) {
    database.deleteProduct(product.toCompanion(true)).then((value) {
      setState(() {
        products.remove(product);
        preferences.deleteForPreferences(product.price, product.stock);
      });
    });
  }

  Widget productIcon(Product product) {
    if(!fromDatabase) {
      var isFavorite = false;
      if(product.isFavorite != null) {
        isFavorite = product.isFavorite!;
      }
      return IconButton(
        icon: const Icon(Icons.favorite),
        color: isFavorite ? Colors.red : Colors.grey,
        onPressed: () => saveProduct(product),
      );
    }
    return IconButton(
      onPressed: () => deleteProduct(product),
      icon: const Icon(Icons.delete),
    );
  }

  Widget buildProduct(Product product) {
    return styler.withPadding(
      widget: Card(
        elevation: 2,
        child: ListTile(
          leading: Image.network(
            product.thumbnail,
            height: 35,
          ),
          title: Text(product.title),
          subtitle: styler.withPadding(
            widget: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(product.description),
                styler.withPadding(
                  widget: Row(
                    children: [
                      Text("Price: ", style: textStyle,),
                      Text("${product.price}")
                    ],
                  ),
                  padding: styler.topBottomPadding(value: 5)
                ),
                Row(
                  children: [
                    Text("Stock: ", style: textStyle,),
                    Text("${product.stock}")
                  ],
                )
              ],
            ),
            padding: styler.topBottomPadding()
          ),
          trailing: productIcon(product),
        ),
      )
    );
  }

  Widget buildProducts() {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => buildProduct(products[index]),
    );
  }

  Widget? leadingBack() {
    return fromDatabase ? IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => nav.back(context),
    ) : null;
  }
  List<Widget>? actionsBar() {
    var action = IconButton(
      icon: Icon(fromDatabase ? Icons.saved_search : Icons.list),
      onPressed: () {
        if(fromDatabase) {
          showDialog(context: context, builder: (context) => dialog.buildDialog());
        } else {
          nav.to(context, const ListProducts(fromDatabase: true));
        }
      },
    );

    return [action];
  }

  void loadDatabase() {
    if(fromDatabase && !loadedFromDatabase) {
      database.listProducts().then((value) {
        setState(() {
          products = value;
          loadedFromDatabase = true;
        });
      });
    }

    database.listProducts().then((value) {
      setState(() {
        products = products.map((e) => e.copyWith(isFavorite: valueOf(null))).toList();
        for (var element in value) {
          final index = products.indexOf(element.copyWith(isFavorite: valueOf(null)));
          if(index != -1) {
            products[index] = element.copyWith(isFavorite: valueOf(true));
          }
        }
        loadedFromDatabase = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    database = Provider.of(context);
    loadDatabase();
    return Scaffold(
      appBar: AppBar(
        title: Text(fromDatabase ? "My products" : "Products"),
        leading: leadingBack(),
        actions: actionsBar(),
      ),
      body: buildProducts(),
    );
  }
}
