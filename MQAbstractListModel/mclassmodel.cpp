#include "mclassmodel.h"
MClassModel::MClassModel(QObject *parent) : QAbstractListModel(parent)
{
}
QHash<int, QByteArray> MClassModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[DATE] = "date";
    roles[AGE] = "age";
    roles[NAME] = "name";
    roles[LOVE] = "love";
    return roles;
}
int MClassModel::rowCount(const QModelIndex &parent) const
{
//    Q_UNUSED(parent);
    do{
        (void)(parent);
    }while(0);
    return m_list.count();
}

QVariant MClassModel::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= m_list.count()){
        return QVariant();
    }
    return datafromIndex(index.row(), role);
}

QVariant MClassModel::datafromIndex(const int &index, int role) const
{
    QVariant value{QVariant::fromValue<QString>("")};
    switch(role){
    case MClassModel::DATE:
        value = QVariant::fromValue<QString>(m_list.at(index).date);
        break;
    case MClassModel::AGE:
        value = QVariant::fromValue<int>(m_list.at(index).age);
        break;
    case MClassModel::LOVE:
        value = QVariant::fromValue<bool>(m_list.at(index).love);
        break;
    case MClassModel::NAME:
        value = QVariant::fromValue<QString>(m_list.at(index).name);
        break;
    }
    return value;
}
void MClassModel::addMStruct(const MStruct &mstruct)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_list<<mstruct;
    endInsertRows();
}
