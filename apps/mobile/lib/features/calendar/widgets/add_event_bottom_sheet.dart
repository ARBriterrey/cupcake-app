import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/models/calendar_event.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/calendar_providers.dart';

/// Bottom sheet for adding a new calendar event
class AddEventBottomSheet extends ConsumerStatefulWidget {
  final DateTime? initialDate;

  const AddEventBottomSheet({
    super.key,
    this.initialDate,
  });

  @override
  ConsumerState<AddEventBottomSheet> createState() => _AddEventBottomSheetState();
}

class _AddEventBottomSheetState extends ConsumerState<AddEventBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();

  EventType _selectedType = EventType.moment;
  EventVisibility _visibility = EventVisibility.shared;
  late DateTime _selectedDate;
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay? _endTime;
  bool _isAllDay = false;
  String? _selectedColor;
  final List<String> _tags = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add a moment together',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textDark,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        color: AppTheme.textLight,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Title field
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      hintText: 'What would you like to remember?',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    autofocus: true,
                  ),

                  const SizedBox(height: 16),

                  // Event type selector
                  _buildEventTypeSelector(),

                  const SizedBox(height: 16),

                  // Date and time pickers
                  _buildDateTimePickers(),

                  const SizedBox(height: 16),

                  // Description field
                  TextFormField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Description (optional)',
                      hintText: 'Add some details...',
                    ),
                    maxLines: 3,
                  ),

                  const SizedBox(height: 16),

                  // Location field
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      labelText: 'Location (optional)',
                      hintText: 'Where will this happen?',
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Visibility toggle
                  _buildVisibilityToggle(),

                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _saveEvent,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryPink,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Save'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEventTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Event type',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: EventType.values.map((type) {
            final isSelected = _selectedType == type;
            return ChoiceChip(
              label: Text(_getEventTypeLabel(type)),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedType = type;
                  });
                }
              },
              backgroundColor: Colors.white,
              selectedColor: AppTheme.primaryPink.withOpacity(0.2),
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.textDark : AppTheme.textLight,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: isSelected
                      ? AppTheme.primaryPink
                      : AppTheme.textLight.withOpacity(0.3),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateTimePickers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // All day toggle
        Row(
          children: [
            Checkbox(
              value: _isAllDay,
              onChanged: (value) {
                setState(() {
                  _isAllDay = value ?? false;
                });
              },
              activeColor: AppTheme.primaryPink,
            ),
            const Text(
              'All day',
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Date picker
        InkWell(
          onTap: () => _selectDate(context),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.warmGray,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const SizedBox(width: 12),
                Text(
                  DateFormat('EEEE, MMMM d, y').format(_selectedDate),
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),

        if (!_isAllDay) ...[
          const SizedBox(height: 12),

          // Time pickers
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectStartTime(context),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.warmGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          _startTime.format(context),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: InkWell(
                  onTap: () => _selectEndTime(context),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.warmGray,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.access_time, size: 20),
                        const SizedBox(width: 12),
                        Text(
                          _endTime?.format(context) ?? 'End time',
                          style: TextStyle(
                            fontSize: 14,
                            color: _endTime == null
                                ? AppTheme.textLight
                                : AppTheme.textDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildVisibilityToggle() {
    return Row(
      children: [
        const Icon(
          Icons.visibility_outlined,
          size: 20,
          color: AppTheme.textLight,
        ),
        const SizedBox(width: 8),
        const Text(
          'Visibility:',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textDark,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: SegmentedButton<EventVisibility>(
            segments: const [
              ButtonSegment(
                value: EventVisibility.shared,
                label: Text('Shared'),
                icon: Icon(Icons.people_outline, size: 16),
              ),
              ButtonSegment(
                value: EventVisibility.private,
                label: Text('Private'),
                icon: Icon(Icons.lock_outline, size: 16),
              ),
            ],
            selected: {_visibility},
            onSelectionChanged: (Set<EventVisibility> selected) {
              setState(() {
                _visibility = selected.first;
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return AppTheme.primaryPink.withOpacity(0.2);
                }
                return Colors.transparent;
              }),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryPink,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryPink,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? _startTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryPink,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _endTime = picked;
      });
    }
  }

  Future<void> _saveEvent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Combine date and time
      DateTime startDateTime;
      DateTime? endDateTime;

      if (_isAllDay) {
        startDateTime = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
        );
      } else {
        startDateTime = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _startTime.hour,
          _startTime.minute,
        );

        if (_endTime != null) {
          endDateTime = DateTime(
            _selectedDate.year,
            _selectedDate.month,
            _selectedDate.day,
            _endTime!.hour,
            _endTime!.minute,
          );
        }
      }

      // Create the event
      await ref.read(calendarEventCreatorProvider.notifier).createEvent(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
            startTime: startDateTime,
            endTime: endDateTime,
            isAllDay: _isAllDay,
            eventType: _selectedType,
            location: _locationController.text.trim().isEmpty
                ? null
                : _locationController.text.trim(),
            visibility: _visibility,
            color: _selectedColor,
            tags: _tags,
          );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Event added successfully!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding event: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  String _getEventTypeLabel(EventType type) {
    switch (type) {
      case EventType.moment:
        return 'Moment';
      case EventType.date:
        return 'Date';
      case EventType.appointment:
        return 'Appointment';
      case EventType.reminder:
        return 'Reminder';
      case EventType.anniversary:
        return 'Anniversary';
      case EventType.other:
        return 'Other';
    }
  }
}
