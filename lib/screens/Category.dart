import 'package:flutter/material.dart';
import 'package:sjnews/data/news.dart';
import 'package:sjnews/models/article_model.dart';
import 'package:sjnews/screens/Article.dart';

class Category extends StatefulWidget {

  final String category;
  Category({this.category});


  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  List<ArticleModel> articles=new List<ArticleModel>();
  bool _loading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    CategoryNews newsClass=CategoryNews();
    await newsClass.getNews(widget.category);
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
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
      body: _loading ? Center(
        child: Container (
          child: CircularProgressIndicator(),
        ),
      ):
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
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