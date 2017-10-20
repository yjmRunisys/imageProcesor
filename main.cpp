#include <QGuiApplication>
#include<QQuickView>
#include<QtQml>
#include <imageprocessor.h>
#include <QQuickItem>
#include <QDebug>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterType<ImageProcessor>("an.qt.ImageProcessor",1,0,"ImageProcessor");

    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setSource(QUrl(QStringLiteral("qrc:/main.qml")));
    viewer.show();

    return app.exec();
}


//#include <QGuiApplication>
//#include <QQmlApplicationEngine>

//int main(int argc, char *argv[])
//{
//    QGuiApplication app(argc, argv);

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

//    return app.exec();
//}
