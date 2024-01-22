import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:note_app/controller/note_controller.dart';
import 'package:note_app/view/add_note_page.dart';
import 'package:note_app/view/note_detailed_page.dart';
import 'package:note_app/widgets/alarm_dialog.dart';
import 'package:note_app/widgets/search_bar.dart';

//D:\Flutter-apps\note_app\lib\widgets\search_bar.dart

class HomePage extends StatelessWidget {
  final controller = Get.put(NoteController());

  Widget emptyNotes() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/note.json'),
          SizedBox(height: 50),
          Text(
            "You don't have any Notes",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget viewNotes() {
    return GridView.builder(
      itemCount: controller.notes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the cross-axis count as needed
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 20.0,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(NoteDetailPage(), arguments: index);
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialogWidget(
                  contentText: "Are you sure you want to delete the note?",
                  confirmFunction: () {
                    controller.deleteNote(controller.notes[index].id!);
                    Get.back();
                  },
                  declineFunction: () {
                    Get.back();
                  },
                );
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.notes[index].title ?? '',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  controller.notes[index].content ?? '',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                  maxLines: 6,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  controller.notes[index].dateTimeEdited ?? '',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch<String>(context: context, delegate: SearchBarWidget());
            },
          ),
          PopupMenuButton(
            onSelected: (val) {
              if (val == 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialogWidget(
                      contentText: "Are you sure you want to delete all notes?",
                      confirmFunction: () {
                        controller.deleteAllNotes();
                        Get.back();
                      },
                      declineFunction: () {
                        Get.back();
                      },
                    );
                  },
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Delete All Notes",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => controller.isEmpty() ? emptyNotes() : viewNotes(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddNewNotePage());
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
