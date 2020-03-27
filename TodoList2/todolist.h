#ifndef TODOLIST_H
#define TODOLIST_H

#include <QObject>
#include <QVector>

struct TodoItem {
    bool done;
    QString description;
};

class TodoList : public QObject
{
    Q_OBJECT
public:
    explicit TodoList(QObject *parent = nullptr);

    QVector<TodoItem> items() const;

    bool setItemAt(int index, const TodoItem &item);

signals:
    // XXX: Purpose of these?
    void preItemAppended();
    void postItemAppended();

    void preItemRemoved(int index);
    void postItemRemoved();

public slots:
    // XXX: Purpose of these?
    void appendItem();
    void removeCompletedItem();

private:
    QVector<TodoItem> items_;
};

#endif // TODOLIST_H
