import 'package:Shopping/providers/product.dart';
import 'package:Shopping/providers/productsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/EditProducts';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final priceFocusNode = FocusNode();
  final descriptionFocusNode = FocusNode();
  final imageURLController = TextEditingController();
  final imageURLFocusNode = FocusNode();
  final form = GlobalKey<FormState>();
  var editedProduct =
      Product(id: null, title: '', description: '', price: 0, imageUrl: '');
  var initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var isInit = true;
  var isLoading = false;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productID = ModalRoute.of(context).settings.arguments as String;
      if (productID != null) {
        editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findByID(productID);
        initValues = {
          'title': editedProduct.title,
          'description': editedProduct.description,
          'price': editedProduct.price.toString(),
          'imageUrl': '',
        };
        imageURLController.text = editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    imageURLFocusNode.addListener(updateImageURL);
    super.initState();
  }

  void updateImageURL() {
    if (!imageURLFocusNode.hasFocus) {
      var text = imageURLController.text;
      if ((!text.startsWith('http') && !text.startsWith('https'))) {
        //     (!text.endsWith('png') &&
        //         !text.endsWith('.jpg') &&
        //         !text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    priceFocusNode.dispose();
    descriptionFocusNode.dispose();
    imageURLController.dispose();
    imageURLFocusNode.removeListener(updateImageURL);
    imageURLFocusNode.dispose();
    super.dispose();
  }

  Future<void> saveForm() async {
    final isValid = form.currentState.validate();
    if (!isValid) {
      return;
    }
    form.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (editedProduct.id != null) {
      await Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(editedProduct.id, editedProduct);
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(editedProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("An error occured"),
                  content: Text(error.toString()),
                  actions: [
                    FlatButton(
                      child: Text("Okay"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
        // } finally {
        //   setState(() {
        //     isLoading = false;
        //   });
        //   Navigator.of(context).pop();
        // }

      }
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: saveForm,
          )
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.all(10)),
                      TextFormField(
                        initialValue: initValues['title'],
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(priceFocusNode);
                        },
                        onSaved: (value) {
                          editedProduct = Product(
                            title: value,
                            description: editedProduct.description,
                            id: editedProduct.id,
                            isFavorite: editedProduct.isFavorite,
                            imageUrl: editedProduct.imageUrl,
                            price: editedProduct.price,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Add text in the box";
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                          initialValue: initValues['price'],
                          decoration: InputDecoration(labelText: 'Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          focusNode: priceFocusNode,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(descriptionFocusNode);
                          },
                          onSaved: (value) {
                            editedProduct = Product(
                              title: editedProduct.title,
                              description: editedProduct.description,
                              id: editedProduct.id,
                              isFavorite: editedProduct.isFavorite,
                              imageUrl: editedProduct.imageUrl,
                              price: double.parse(value),
                            );
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter a price";
                            }
                            if (double.tryParse(value) == null) {
                              return "Please enter a valid number";
                            }
                            if (double.parse(value) <= 0) {
                              return "Please enter a number greater than 0";
                            }
                            return null;
                          }),
                      TextFormField(
                          initialValue: initValues['description'],
                          decoration: InputDecoration(labelText: 'Description'),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          focusNode: descriptionFocusNode,
                          onSaved: (value) {
                            editedProduct = Product(
                              title: editedProduct.title,
                              description: value,
                              id: editedProduct.id,
                              isFavorite: editedProduct.isFavorite,
                              imageUrl: editedProduct.imageUrl,
                              price: editedProduct.price,
                            );
                          },
                          validator: (value) {
                            if (value.length < 10) {
                              return "enter text greater than 10 characters";
                            }
                            if (value.isEmpty) {
                              return "Add enter a description";
                            } else {
                              return null;
                            }
                          }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: imageURLController.text.isEmpty
                                ? Text("Enter a URL")
                                : FittedBox(
                                    child:
                                        Image.network(imageURLController.text),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: imageURLController,
                                focusNode: imageURLFocusNode,
                                onFieldSubmitted: (value) => saveForm(),
                                onSaved: (value) {
                                  editedProduct = Product(
                                    title: editedProduct.title,
                                    description: editedProduct.description,
                                    id: editedProduct.id,
                                    isFavorite: editedProduct.isFavorite,
                                    imageUrl: value,
                                    price: editedProduct.price,
                                  );
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Please enter a imageURL";
                                  }
                                  if (!value.startsWith('http') &&
                                      !value.startsWith('https')) {
                                    return 'Please enter a valid URL';
                                  }
                                  // if (!value.endsWith('png') &&
                                  //     !value.endsWith('.jpg') &&
                                  //     !value.endsWith('jpeg')) {
                                  //   return "Enter a valid Image URL";
                                  // }
                                  return null;
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
