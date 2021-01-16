#ifndef MCLASSMODEL_H
#define MCLASSMODEL_H
# include <QAbstractListModel>
#include <QDebug>
typedef struct MStruct{
    QString date = "--:--:----";
    int age = 0;
    QString name="";
    bool love=false;
}MStruct;
Q_DECLARE_METATYPE(MStruct);



class MClassModel: public QAbstractListModel
{
    Q_OBJECT
public:
    MClassModel(QObject* parent = nullptr);
    enum MRole: int{
        DATE = Qt::UserRole+1,
        AGE,
        NAME,
        LOVE,
    };



    QHash<int, QByteArray> roleNames() const override;
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role= Qt::DisplayRole) const override;
    QVariant datafromIndex(const int& index, int role) const;
    void addMStruct(const MStruct& mstruct);
    void createMStruct(MStruct &mstruct, QString date, int age, QString name, bool love){
        mstruct.date = date;
        mstruct.age = age;
        mstruct.name = name;
        mstruct.love = love;
    }
private:
    QList<MStruct> m_list;
};



#endif // MCLASSMODEL_H
