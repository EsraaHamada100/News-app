import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:News_App/modules/web_view/web_view_screen.dart';

Widget buildArticleItem(article, context) => InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => WebViewScreen(url: article['url']),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              height: 120,

              width: 150,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white70,
              ),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  article['urlToImage'].toString(),

                  fit: BoxFit.cover,

                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Image(
                      image: NetworkImage(
                          'https://www.worldartfoundations.com/wp-content/uploads/2022/04/placeholder-image.png'),
                      fit: BoxFit.cover,
                    );
                  },

                  // loadingBuilder: (BuildContext context, _ , ImageChunkEvent? loadingProgress) {

                  //   return Center(

                  //     child: CircularProgressIndicator(

                  //         strokeWidth : 4.0

                  //     ),

                  //   );

                  // },
                ),
              ),

              // child: Image(image: NetworkImage(

              //   '${article['urlToImage']}',

              // ),fit: BoxFit.cover,),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: Theme.of(context).textTheme.bodyText2,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget defaultFormField(
    {required controller,
    required type,
    required validate,
    required prefix,
    required onChange,
    String label = ""}) {
  return TextFormField(
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: label,
      icon: prefix,
    ),
    controller: controller,
    keyboardType: type,
    validator: validate,
    onChanged: onChange,
  );
}
