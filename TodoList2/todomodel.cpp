#include "todomodel.h"

#include "todolist.h"

TodoModel::TodoModel(QObject *parent)
    : QAbstractListModel(parent),
      list_(nullptr)
{
}

int TodoModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid() || !list_)
        return 0;

    return list_->items().size();
}

QVariant TodoModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !list_)
        return QVariant();

    const TodoItem item = list_->items().at(index.row());
    switch (role) {
    case DoneRole:
        return QVariant(item.done);
    case DescriptionRole:
        return QVariant(item.description);
    }

    return QVariant();
}

bool TodoModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (!list_) {
        return false;
    }

    TodoItem item = list_->items().at(index.row());
    switch (role) {
    case DoneRole:
        item.done = value.toBool();
        break;
    case DescriptionRole:
        item.description = value.toString();
        break;
    }

    if (list_->setItemAt(index.row(), item)) {
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags TodoModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> TodoModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[DoneRole] = "done";
    names[DescriptionRole] = "description";
    return names;
}

TodoList *TodoModel::list() const
{
    return list_;
}

void TodoModel::setList(TodoList *list)
{
    beginResetModel();
    if (list_) {
        list_->disconnect(this);
    }

    list_ = list;

    if (list_) {
        connect(list_, &TodoList::preItemAppended, this, [=]() {
            const int index = list_->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });
        connect(list_, &TodoList::postItemAppended, this, [=]() {
            endInsertRows();
        });

        connect(list_, &TodoList::preItemRemoved, this, [=](int index) {
            beginRemoveRows(QModelIndex(), index, index);
        });
        connect(list_, &TodoList::postItemRemoved, this, [=]() {
            endRemoveRows();
        });
    }

    endResetModel();
}
