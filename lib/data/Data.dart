import 'package:sjnews/models/CategoryModel.dart';

List<CategoryModel> getCategories(){

  List<CategoryModel> category=new List<CategoryModel>();
  CategoryModel categoryModel=new CategoryModel();

  //1
  categoryModel.categoryName="Business";
  category.add(categoryModel);
  categoryModel=new CategoryModel();
  //2
  categoryModel.categoryName="Entertainment";
  category.add(categoryModel);
  categoryModel=new CategoryModel();
  //3
  categoryModel.categoryName="General";
  category.add(categoryModel);
  categoryModel=new CategoryModel();
  //4
  categoryModel.categoryName="Health";
  category.add(categoryModel);
  categoryModel=new CategoryModel();
  //5
  categoryModel.categoryName="Science";
  category.add(categoryModel);
  categoryModel=new CategoryModel();
  //6
  categoryModel.categoryName="Sports";
  category.add(categoryModel);
  categoryModel=new CategoryModel();
  //7
  categoryModel.categoryName="Technology";
  category.add(categoryModel);
  categoryModel=new CategoryModel();

  return category;
}