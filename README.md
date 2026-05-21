# 📝 To-Do List App

Ứng dụng quản lý công việc (To-Do List) được xây dựng bằng Flutter với kiến trúc BLoC/Cubit, hỗ trợ đa ngôn ngữ (Tiếng Việt và Tiếng Anh).

## ✨ Tính năng

- ✅ Thêm, sửa, xóa công việc
- 📅 Quản lý công việc theo ngày
- ⏰ Đặt thời gian bắt đầu và kết thúc cho mỗi công việc
- 📝 Thêm mô tả chi tiết cho công việc
- ✔️ Đánh dấu công việc đã hoàn thành
- 💾 Lưu trữ dữ liệu cục bộ với Floor Database
- 🎨 Giao diện thân thiện và dễ sử dụng

## 🏗️ Kiến trúc

Dự án sử dụng kiến trúc **BLoC Pattern** và **Cubit** để quản lý state:

```
lib/
├── main.dart                 # Entry point của ứng dụng
├── core/                     # Core modules
│   ├── constants/            # Các hằng số
│   └── router/              # Cấu hình routing (GoRouter)
└── ui/                       # UI Layer
    ├── blocs/               # Business Logic Components
    │   └── task/            # Task BLoC
    ├── cubits/              # Cubits cho state management
    ├── models/              # Data models
    ├── repositories/        # Data repositories
    ├── screens/             # Các màn hình
    ├── services/            # Services (Database DAO)
    └── widgets/             # Reusable widgets
```

## 📦 Dependencies chính

- **flutter_bloc** - State management với BLoC pattern
- **floor** - SQLite database abstraction
- **go_router** - Declarative routing
- **month_year_picker** - Date picker widget
- **flutter_localizations** - Hỗ trợ đa ngôn ngữ

## 🚀 Cài đặt

### Yêu cầu

- Flutter SDK: >= 2.19.0
- Dart SDK: >= 2.19.0

### Các bước cài đặt

1. Clone repository:
```bash
git clone <repository-url>
cd to_do_list
```

2. Cài đặt dependencies:
```bash
flutter pub get
```

3. Chạy build runner để generate code cho Floor database:
```bash
flutter packages pub run build_runner build
```

4. Chạy ứng dụng:
```bash
flutter run
```

## 🎯 State Management

Ứng dụng sử dụng các Cubit và BLoC sau:

- **TaskBloc** - Quản lý CRUD operations cho tasks
- **CheckboxCubit** - Quản lý trạng thái checkbox
- **SelectDayCubit** - Quản lý ngày được chọn
- **DatetimeNowCubit** - Quản lý thời gian hiện tại
- **LoadingGlobalCubit** - Quản lý trạng thái loading toàn cục
- **LoadingInternalCubit** - Quản lý trạng thái loading nội bộ
- **DatabaseCubit** - Quản lý database operations

## 💾 Data Layer

### Task Model

```dart
class Task {
  final int id;
  final String title;
  final String date;
  final String description;
  final String startTime;
  final String endTime;
  final TaskStatus status; // pending hoặc completed
}
```

### Database

Sử dụng **Floor** (SQLite wrapper) để lưu trữ dữ liệu cục bộ với:
- Task DAO để thực hiện các thao tác CRUD
- Automatic migrations
- Type converters cho enum

## 📱 Màn hình

1. **Start Screen** - Màn hình khởi động
2. **Tasks Screen** - Danh sách công việc chính
3. **New Task Screen** - Thêm/Sửa công việc
4. **Stats Screen** - Thống kê công việc
5. **Settings Screen** - Cài đặt ứng dụng
6. **Bottom Navigation** - Điều hướng giữa các màn hình

## 🌐 Localization

Ứng dụng hỗ trợ 2 ngôn ngữ:
- 🇻🇳 Tiếng Việt
- 🇬🇧 English

## 🔧 Build & Deploy

### Build APK
```bash
flutter build apk --release
```

### Build iOS
```bash
flutter build ios --release
```

### Build Web
```bash
flutter build web
```

## 🤝 Đóng góp

Mọi đóng góp đều được hoan nghênh! Vui lòng:

1. Fork project
2. Tạo feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Mở Pull Request

## 📄 License

Dự án này được phân phối dưới giấy phép MIT. Xem file `LICENSE` để biết thêm chi tiết.

## 📧 Liên hệ

Nếu bạn có bất kỳ câu hỏi nào, vui lòng liên hệ qua email hoặc tạo issue trên GitHub.

---

**Made with ❤️ using Flutter**