#ifndef MYLANGUAGE_H
#define MYLANGUAGE_H
#include <QObject>
#include <QLocale>

class MyLanguage : public QObject
{
    Q_OBJECT
public:
    MyLanguage(){}
    enum M_Language: int{
        ENG = QLocale::English,
        VN  = QLocale::Vietnamese
    };
    Q_ENUM(M_Language);
};

#endif // MYLANGUAGE_H
