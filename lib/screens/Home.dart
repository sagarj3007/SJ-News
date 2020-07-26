import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjnews/data/Data.dart';
import 'package:sjnews/data/news.dart';
import 'package:sjnews/models/CategoryModel.dart';
import 'package:sjnews/models/article_model.dart';
import 'package:sjnews/screens/Article.dart';
import 'package:sjnews/screens/Category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories=new List<CategoryModel>();
  List<ArticleModel> articles=new List<ArticleModel>();
  bool _loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories=getCategories();
    getNews();
  }

  getNews() async{
    News newsClass=News();
    await newsClass.getNews();
    articles=newsClass.news;
    setState(() {
      _loading=false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("SJ"),
            Text("News",style: TextStyle(color: Colors.blue),),
          ],
        ),
      ),
      body: _loading ? Center(
        child: Container (
          child: CircularProgressIndicator(),
        ),
      )
          : SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
            children: <Widget>[

              //categories
              Container(
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    return Tile(
                      tileName:categories[index].categoryName,
                    );
                    }),
              ),

              //articles
              Container(
                padding: EdgeInsets.only(top:16),
                child: ListView.builder(
                  itemCount: articles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index){
                    return TileBlog(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      description: articles[index].description,
                      url: articles[index].url,
                    );
                    }),
              ),
            ],
        ),
      ),
          ),
    );
  }
}

class Tile extends StatelessWidget {

  final String tileName;
  Tile({this.tileName});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Category(
            category: tileName.toLowerCase(),
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.blue,
              ),
              child: Text(tileName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TileBlog extends StatelessWidget {

  final String imageUrl, title, description,url;
  TileBlog({@required this.imageUrl, @required this.title, @required this.description, @required this.url});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Article(
            blogUrl: url,
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imageUrl)),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(
              fontSize: 16, color: Colors.black87, fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 8,),
            Text(description, style: TextStyle(
              color: Colors.black54),),
          ],
        ),
      ),
    );
  }
}
