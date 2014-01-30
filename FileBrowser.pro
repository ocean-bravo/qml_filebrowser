QT += gui core quick qml

# Add more folders to ship with the application, here
folder_01.source = qml/gas
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =$$PWD/qml

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.


RESOURCES += \
    resourses.qrc

OTHER_FILES += \
    qml/main.qml \
    qml/FileBrowser.qml

HEADERS += \
    DriveList.h
