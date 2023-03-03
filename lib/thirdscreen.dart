import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pcod/HomePage.dart';
import 'package:pcod/exercise%20and%20yoga.dart';
import 'package:pcod/main.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
List<String> dailyyogaposes = [
  'Samisthithi',
  'Uttanasana',
  'Phalakasana',
  'Adho Mukha Svanasana',
  'Veerbhadrasana 1',
  'Eka Pada Adho Mukha Svanasana',
  'Veerabhadrasana 2',
  'Veerabhadrasana 3',
  'Utkatasana',
  'Bhujagasana',
  'Bidalasana',
  'Bitilasana',
  'Ustrasana',
  'Setubandhasana',
  'Catur Svanasana',
  'Salabhasana',
];
List<String> FullBodyPoses = [
  'Eka Pada Padangusthasana',
  'Trikonasana',
  'Vrikshasana',
  'Utthita ashwa sanchalanasana',
  'Parsvakonasana',
  'Utthita Parsvakonasana',
  'Urdhva Virabhadrasana',
  'Parivrtta Anjaneyasana',
  'Prasarita Padottanasana',
  'Paschimottanasana',
  'Marichhasana C',
  'Malasana',
  'Baddhakonasana',
  'Eka Pada Rajakapotasana',
  'Sarvangasana',
];
List<String> PosesForRepair = [
  'Parivrtta Sukhasana',
  'Upavishtakonasana',
  'Marichhasana A',
  'Shasangasana',
  'Gomukhasana',
  'Janushirshasana',
  'Balasana',
  'Salambh Bhujagasana',
  'Uttana Shishosana',
  'Bharmanasana',
  'Utthan Pristhasana',
  'Urdhva Mukha Pasasana',
  'Supta Matsyendrasana',
  'Supta Baddha Konasana',
  'Supta padagushtasana',
  'Anand Balasana',
];

class thirdscreen extends StatefulWidget {
  String name, imagepath, desc;
  int ind;
  List<String> tags;
  thirdscreen(this.name, this.imagepath, this.desc, this.tags, this.ind);
  @override
  State<thirdscreen> createState() => _thirdscreenState();
}

class _thirdscreenState extends State<thirdscreen> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions:<Widget> [

      ],
      content:Expanded(
        child: Container(
    height: MediaQuery.of(context).size.height*0.5,
    child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 5, right: 10, bottom: 10),
            child: Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // color:Colors.amber,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size(50, 80),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.center),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomePage(Hive_box_Homepage)
                            ),
                          );
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        )),
                  ),
                  Flexible(
                    child: Text(
                      "${widget.name}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                  },
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    color: Colors.black,
                  )),
              Container(
                width: SizeConfig.screenWidth * 0.5,
                child: Image.asset(
                  "${widget.imagepath}",
                  fit: BoxFit.fitHeight,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.black,
                  ))
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Text(
              '${widget.name}',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Text(
                "${widget.desc}",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                for (int i = 0; i < widget.tags.length; i++)
                  tags("${widget.tags[i]}"),
              ],
            ),
          ),
        ],
    ),
        ),
      ),
    );
  }
}

class tags extends StatelessWidget {
  String name;
  tags(this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 20.0,
          maxWidth: 100.0,
          minHeight: 20.0,
          minWidth: 30.0,
        ),
        decoration: BoxDecoration(
            color: Color(0xEC9D0649),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 2, bottom: 2, right: 8),
          child: Text(
            '$name',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 10,
            ),
          ),
        ),
      ),
    );
  }
}
