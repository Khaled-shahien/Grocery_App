import 'package:flutter/material.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Expanded(
          child: Stack(
            children: [
              //Background Image______________________
              Image.asset("images/tomatos.jpg", fit: BoxFit.cover),

              // Content Container____________________
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      const Text(
                        "FRESH TOMATOES",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                        ),
                      ),

                      // Title + Qty
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "₹50/kg",
                            style: TextStyle(
                              color: Color(0xffFFD600),
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Row(
                            children: [
                              SizedBox(width: 30),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove),
                              ),
                              const Text(
                                "3 kgs",
                                style: TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 5),

                      // const Text(
                      //   "₹50/kg",
                      //   style: TextStyle(color: Color(0xffFFD600), fontSize: 25, fontWeight: FontWeight.w600),
                      // ),
                      const SizedBox(height: 10),

                      // Rating + Avatars
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 20,
                          ),
                          const Text("4.5 ", style: TextStyle(fontSize: 20)),
                          const Text(
                            "(128 reviews)",
                            style: TextStyle(fontSize: 20),
                          ),
                          const Spacer(),
                          CircleAvatarProfile(
                            image: "assets/images/person1.png",
                          ),
                          SizedBox(width: 4),
                          CircleAvatarProfile(
                            image: "assets/images/person2.png",
                          ),
                          SizedBox(width: 4),
                          CircleAvatarProfile(
                            image: "assets/images/person3.png",
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Tabs
                      Row(
                        children: const [
                          Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Review",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Discussion",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Description text
                      const Text(
                        "Why are tomatoes healthy? Tomatoes are loaded with lycopene..."
                        "They protect your cells from sun damage and provide vitamins B & E.",
                        style: TextStyle(
                          fontSize: 20,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Bottom Buttons
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Color(0xff12B76A),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: Color(0xffFFD600)),
                              ),
                              child: Center(
                                child: Text(
                                  "ADD TO CART\n ₹150",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CircleAvatarProfile extends StatelessWidget {
  const CircleAvatarProfile({required this.image, super.key});
  final String image;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: 20, backgroundImage: AssetImage(image));
  }
}
