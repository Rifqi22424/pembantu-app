import 'package:flutter/material.dart';
import 'package:prt/src/api/announcement_service.dart';

import '../models/announcement_model.dart';

enum AnnouncementState { initial, loading, loaded, error }

class AnnouncementProvider with ChangeNotifier {
  final AnnouncementService _announcementService = AnnouncementService();
  List<Announcement> _announcements = [];
  Announcement? _announcement;
  AnnouncementState _state = AnnouncementState.initial;
  String? _errorMessage;

  List<Announcement> get announcements => _announcements;
  Announcement? get announcement => _announcement;
  AnnouncementState get state => _state;
  String? get errorMessage => _errorMessage;

  Future<void> getAnnouncements() async {
    _state = AnnouncementState.loading;
    notifyListeners();
    try {
      _announcements = await _announcementService.fetchAnnouncements();
      _state = AnnouncementState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
      _state = AnnouncementState.error;
    }
    notifyListeners();
    print(_state);
  }

  Future<void> getAnnouncementDetail(int id) async {
    _state = AnnouncementState.loading;
    try {
      _announcement = await _announcementService.fetchAnnouncementDetail(id);
      _state = AnnouncementState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
      _state = AnnouncementState.error;
    }
    notifyListeners();
  }
}
