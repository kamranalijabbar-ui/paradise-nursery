import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String timestamp;
  final IconData icon;
  final Color iconColor;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.icon,
    required this.iconColor,
    this.isRead = false,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<NotificationItem> _notifications = [
    NotificationItem(
      id: '1',
      title: 'Order Delivered 🎉',
      message: 'Your plant order #1092 has been delivered successfully.',
      timestamp: '2 mins ago',
      icon: Icons.local_shipping,
      iconColor: Colors.green,
      isRead: false,
    ),
    NotificationItem(
      id: '2',
      title: 'Special Offer! 🏷️',
      message: 'Get 20% off on all indoor succulents today.',
      timestamp: '1 hour ago',
      icon: Icons.local_offer,
      iconColor: Colors.orange,
      isRead: false,
    ),
    NotificationItem(
      id: '3',
      title: 'Security Alert 🔒',
      message: 'Your account password was updated successfully.',
      timestamp: '1 day ago',
      icon: Icons.security,
      iconColor: Colors.blue,
      isRead: true,
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification.isRead = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('All notifications marked as read')),
    );
  }

  void _clearAll() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications ${unreadCount > 0 ? "($unreadCount)" : ""}'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'read_all') _markAllAsRead();
              if (value == 'clear_all') _clearAll();
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'read_all',
                child: Text('Mark all as read'),
              ),
              const PopupMenuItem(
                value: 'clear_all',
                child: Text('Clear all'),
              ),
            ],
          ),
        ],
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No notifications yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.separated(
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _notifications[index];
                return Dismissible(
                  key: Key(item.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() {
                      _notifications.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${item.title} removed')),
                    );
                  },
                  child: ListTile(
                    tileColor: item.isRead
                        ? Colors.transparent
                        : Theme.of(context).primaryColor.withOpacity(0.05),
                    leading: CircleAvatar(
                      backgroundColor: item.iconColor.withOpacity(0.15),
                      child: Icon(item.icon, color: item.iconColor),
                    ),
                    title: Text(
                      item.title,
                      style: TextStyle(
                        fontWeight:
                            item.isRead ? FontWeight.normal : FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(item.message),
                        const SizedBox(height: 6),
                        Text(
                          item.timestamp,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: !item.isRead
                        ? Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                    onTap: () {
                      setState(() {
                        item.isRead = true;
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
