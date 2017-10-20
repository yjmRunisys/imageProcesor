#ifndef IMAGEPROCESSOR_H
#define IMAGEPROCESSOR_H
#include <QObject>
#include<QString>

class ImageProcessorPrivate;
class ImageProcessor:public QObject
{
    Q_OBJECT
    Q_ENUMS(ImageAlgorithm)
    Q_PROPERTY(QString sourceFile READ sourceFile)
    Q_PROPERTY(ImageAlgorithm algorithm READ algorithm)

public:
    ImageProcessor(QObject *parent = 0);
    ~ImageProcessor();

    enum ImageAlgorithm{
        Gray = 0,
        Binarize,
        Negative,
        Emboss,
        Sharpen,
        Soften,
        AlgorithmCount
    };

    QString sourceFile() const;
    ImageAlgorithm algorithm() const;
    void setTempPath(QString tempPath);


signals:
    void finished(QString newFile);
    void progress(int value);

public slots:
    void process(QString file,ImageAlgorithm algorithm);
    void abort(QString file,ImageAlgorithm algorithm);
    QString url2RealPath(QString sourFile);

private:
    ImageProcessorPrivate *m_d;
};

/**
  *@brief 通过finished信号通知关注者处理完毕，提供process方法供客户程序调用，setTempPath
  * 设置临时目录，允许取消待执行的任务
  *@param
  *@author yjm
  *@date 2017-10-19
  */


#endif // IMAGEPROCESSOR_H
