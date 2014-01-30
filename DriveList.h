#pragma once

#include <QObject>
#include <QStringList>
#include <QDir>
#include <QFileInfo>

class DriveList : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList availableDrives READ availableDrives NOTIFY drivesChanged)

signals:
    void drivesChanged();

public:
    QStringList availableDrives()
    {
        QFileInfoList fileList  = QDir::drives();
        QStringList drives;
        foreach(QFileInfo file, fileList)
        {
            if(file.isReadable())
            {
                drives << file.filePath();
            }
        }
        return drives;
    }
};

