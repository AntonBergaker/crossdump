#include "todolist.h"

TodoList::TodoList(QObject *parent) : QObject(parent)
{
    items_.append({true, "Wash the car"});
    items_.append({false, "Clean the sink"});

}

QVector<TodoItem> TodoList::items() const
{
    return items_;
}

bool TodoList::setItemAt(int index, const TodoItem &item)
{
    if (index < 0 || index >= items_.size()) {
        return false;
    }

    const TodoItem &oldItem = items_.at(index);
    if (item.done == oldItem.done && item.description == oldItem.description)
        return false;

    items_[index] = item;
    return true;
}

void TodoList::appendItem()
{
    emit preItemAppended();

    TodoItem item;
    item.done = false;
    items_.append(item);

    emit postItemAppended();
}

void TodoList::removeCompletedItem()
{
    for (int i = 0; i < items_.size(); ) {
        if (items_.at(i).done) {
            emit preItemRemoved(i);

            items_.removeAt(i);

            emit postItemRemoved();
        } else {
            ++i;
        }
    }
}
