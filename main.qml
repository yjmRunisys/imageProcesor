import QtQuick 2.5
import QtQuick.Window 2.2
import an.qt.ImageProcessor 1.0
import QtQuick.Dialogs 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

/*
Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Qt.quit();
        }
    }

    Text {
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }
}
*/
Rectangle{
    width:640;
    height:480;
    color:"#121212";

    BusyIndicator{
        id:busy;
        running: false;
        anchors.centerIn: parent;
        z:2;
    }

    Label{
        id:stateLabel;
        visible:false;
        anchors.centerIn: parent;
    }

    Image{
        objectName:"imageViewer";
        id:imageViewer;
        asynchronous: true;
        anchors.fill: parent;
        fillMode:Image.PreserveAspectFit;
        onStatusChanged: {
            if(imageViewer.status === Image.Loading){
                busy.running = true;
                stateLabel.visible = false;

                console.log("pic loading");
            }
            else if(imageViewer.status === Image.Ready){
                busy.running = false;

                console.log("pic Ready");
            }
            else if(imageViewer.status === Image.Error){
                busy.running = false;
                stateLabel.visible = true;
                stateLabel.text = "ERROR";

                console.log("pic Error");
            }
        }

    }

    ImageProcessor{
        id:processor;
        onFinished:{
            imageViewer.source = "file:///" + newFile;
        }
    }

    FileDialog{
        id:fileDialog;
        title: "Please choose a file";
        nameFilters: ["Image Files (*.jpg *.png *.gif)"];
        onAccepted: {

            console.log(fileDialog.fileUrl);

            imageViewer.source = fileDialog.fileUrl;
        }
    }

    Component{
        id:btnStyle;
        ButtonStyle{
            background: Rectangle{
                implicitWidth: 70;
                implicitHeight: 25;
                border.width: control.pressed? 2:1;
                border.color: (control.pressed || control.hovered)? "#00A060":"#888888";
                radius:6;
                gradient:Gradient{
                    GradientStop{
                        position:0;
                        color:control.pressed? "#cccccc":"#e0e0e0";
                    }
                    GradientStop{
                        position:1;
                        color:control.pressed? "#aaa":"#ccc";
                    }
                }
            }
        }
    }

    Button{
        id:openFile;
        text:"打开";
        anchors.left: parent.left;
        anchors.leftMargin: 6;
        anchors.top:parent.top;
        anchors.topMargin: 6;
        onClicked: {
            fileDialog.visible = true;
        }
        style:btnStyle;
        z:1;
    }

    Button{
        id:quit;
        text:"退出";
        anchors.left: openFile.right;
        anchors.leftMargin: 4;
        anchors.bottom: openFile.bottom;
        anchors.topMargin: 6;
        onClicked: {
            Qt.quit();
        }
        style:btnStyle;
        z:1;
    }

    Rectangle{
        anchors.left: parent.right;
        anchors.top: parent.top;
        anchors.bottom: openFile.bottom;
        anchors.bottomMargin:  -6;
        anchors.right: quit.right;
        anchors.rightMargin:  -6;
        color:"#404040";
        opacity: 0.7;
    }

    Grid{
        id:op;
        anchors.left: parent.left;
        anchors.leftMargin: 4;
        anchors.bottom:parent.bottom;
        anchors.bottomMargin:  4;
        rows:2;
        columns:3;
        rowSpacing: 4;
        columnSpacing: 4;
        z:1;

        Button{
            text:"柔化";
            style:btnStyle;
            onClicked:{
                busy.running = true;
                processor.process(fileDialog.fileUrl,ImageProcessor.Soften);
            }
        }

        Button{
            text:"灰度";
            style:btnStyle;
            onClicked:{
                busy.running = true;
                processor.process(fileDialog.fileUrl,ImageProcessor.Gray);
            }
        }

        Button{
            text:"浮雕";
            style:btnStyle;
            onClicked:{
                busy.running = true;
                processor.process(fileDialog.fileUrl,ImageProcessor.Emboss);
            }
        }

        Button{
            text:"黑白";
            style:btnStyle;
            onClicked:{
                busy.running = true;
                processor.process(fileDialog.fileUrl,ImageProcessor.Binarize);
            }
        }

        Button{
            text:"底片";
            style:btnStyle;
            onClicked:{
                busy.running = true;
                processor.process(fileDialog.fileUrl,ImageProcessor.Negative);
            }
        }

        Button{
            text:"锐化";
            style:btnStyle;
            onClicked:{
                busy.running = true;
                processor.process(fileDialog.fileUrl,ImageProcessor.Sharpen);
            }
        }

        Button{
            text:"柔化";
            style:btnStyle;
            onClicked:{
                busy.running = true;

//                processor.url2RealPath(fileDialog.fileUrl);

//                filePath = fileDialog.fileUrl;
//                nPos = filePath.indexOf(":/");
//                len = filePath.length;
//                filePath = filePath.substring(nPos,len-nPos);
//                console.log(filePath + "in!");

               // string filePath = processor.url2RealPath(fileDialog.fileUrl);
                processor.process(fileDialog.fileUrl,ImageProcessor.Soften);
            }
        }
    }

    Rectangle{
        anchors.left: parent.right;
        anchors.top: op.top;
        anchors.topMargin:  -4;
        anchors.bottom:  parent.bottom;
        anchors.right: op.right;
        anchors.rightMargin:  -4;
        color:"#404040";
        opacity: 0.7;
    }
}
