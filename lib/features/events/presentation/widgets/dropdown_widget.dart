import 'dart:developer';

import 'package:event_listing_app/features/events/provider/event_controller_provider.dart';
import 'package:event_listing_app/features/home/domain/entity/category_entity.dart';
import 'package:event_listing_app/features/home/provider/home_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recase/recase.dart';

class CombinedDropdownWidget extends ConsumerStatefulWidget {
  final CategoryEntity? initialCategory;
  final Function(CategoryEntity)? onCategoryChanged;

  const CombinedDropdownWidget({
    super.key,
    this.initialCategory,
    this.onCategoryChanged,
  });

  @override
  ConsumerState<CombinedDropdownWidget> createState() => _CombinedDropdownWidgetState();
}

class _CombinedDropdownWidgetState extends ConsumerState<CombinedDropdownWidget> {
  CategoryEntity? selectedCategory;
  String? selectedDate;
  String? selectedPrice;
  bool isCategoryLoading = false;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory;
  }

  Future<void> _handleCategoryChange(CategoryEntity? newCategory) async {
    if (newCategory == null || newCategory == selectedCategory) return;

    setState(() {
      isCategoryLoading = true;
      selectedCategory = newCategory;
    });

    try {
      // Clear previous events
      ref.read(eventControllerProvider.notifier).resetEvents();
      
      // Fetch new events
      await ref.read(eventControllerProvider.notifier).fetchEvents(newCategory.link);
    } catch (e) {
      log('Error fetching events: $e');
    } finally {
      if (mounted) {
        setState(() => isCategoryLoading = false);
      }
    }

    widget.onCategoryChanged?.call(newCategory);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryControllerProvider);
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Category Dropdown
          Expanded(
            child: _buildCategoryDropdown(
              categories: state.categories,
              selectedCategory: selectedCategory,
              isLoading: state.isLoading || isCategoryLoading,
              onChanged: _handleCategoryChange,
            ),
          ),
          const SizedBox(width: 12),
          
          // Date Dropdown
          Expanded(
            child: _buildDropdown(
              label: 'Date',
              value: selectedDate,
              items: const ['Today', 'This Week', 'This Month', 'Last 30 Days'],
              onChanged: (value) {
                setState(() => selectedDate = value);
              },
              isEnabled: !isCategoryLoading,
            ),
          ),
          const SizedBox(width: 12),
          
          // Price Dropdown
          Expanded(
            child: _buildDropdown(
              label: 'Price',
              value: selectedPrice,
              items: const ['Any Price', '\$0 - \$50', '\$50 - \$100', '\$100+'],
              onChanged: (value) {
                setState(() => selectedPrice = value);
              },
              isEnabled: !isCategoryLoading,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown({
    required List<CategoryEntity> categories,
    required CategoryEntity? selectedCategory,
    required bool isLoading,
    required ValueChanged<CategoryEntity?> onChanged,
  }) {
    return AbsorbPointer(
      absorbing: isLoading,
      child: Opacity(
        opacity: isLoading ? 0.7 : 1.0,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton<CategoryEntity>(
                  isExpanded: true,
                  value: selectedCategory,
                  hint: _buildDropdownHint('Category', isLoading),
                  icon: _buildDropdownIcon(isLoading),
                  items: _buildCategoryItems(categories),
                  onChanged: onChanged,
                  dropdownColor: Colors.white,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
 
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<CategoryEntity>> _buildCategoryItems(List<CategoryEntity> categories) {
    return categories.map((category) {
      return DropdownMenuItem<CategoryEntity>(
        value: category,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            category.name.titleCase,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool isEnabled = true,
  }) {
    return AbsorbPointer(
      absorbing: !isEnabled,
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.7,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(20),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              hint: _buildDropdownHint(label, false),
              icon: _buildDropdownIcon(!isEnabled),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
              onChanged: isEnabled ? onChanged : null,
              dropdownColor: Colors.white,
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownHint(String text, bool isLoading) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
          if (isLoading) ...[
            const SizedBox(width: 8),
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.grey.shade400,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDropdownIcon(bool isLoading) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: isLoading
          ? const SizedBox(width: 18, height: 18)
          : Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey.shade600,
              size: 18,
            ),
    );
  }
}