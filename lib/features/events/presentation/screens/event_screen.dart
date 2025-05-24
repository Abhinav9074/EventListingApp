import 'package:event_listing_app/features/events/presentation/widgets/dropdown_widget.dart';
import 'package:event_listing_app/features/events/presentation/widgets/event_grid_widget.dart';
import 'package:event_listing_app/features/home/domain/entity/category_entity.dart';
import 'package:event_listing_app/features/events/presentation/widgets/event_widget.dart';
import 'package:event_listing_app/features/events/presentation/widgets/events_appbar.dart';
import 'package:event_listing_app/features/events/provider/event_controller_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key, this.category});

  final CategoryEntity? category;

  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  bool isGridView = false;
  bool isCategoryLoading = false;

  Future<void> _fetchEvents(String url) async {
    try {
      setState(() => isCategoryLoading = true);
      ref.read(eventControllerProvider.notifier).resetEvents();
      await ref.read(eventControllerProvider.notifier).fetchEvents(url);
    } finally {
      if (mounted) {
        setState(() => isCategoryLoading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _fetchEvents(widget.category!.link);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(eventControllerProvider);

    return Scaffold(
      floatingActionButton: IconButton(
        tooltip: isGridView ? 'Switch to List View' : 'Switch to Grid View',
        icon: Icon(isGridView ? Icons.list : Icons.grid_view),
        onPressed:
            isCategoryLoading
                ? null
                : () {
                  setState(() {
                    isGridView = !isGridView;
                  });
                },
      ),
      appBar: EventsAppbar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AbsorbPointer(
                    absorbing: isCategoryLoading,
                    child: Opacity(
                      opacity: isCategoryLoading ? 0.7 : 1.0,
                      child: CombinedDropdownWidget(
                        initialCategory: widget.category,
                        onCategoryChanged: (category) {
                          _fetchEvents(category.link);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (isCategoryLoading && state.events.isEmpty)
              const Expanded(child: Center(child: CupertinoActivityIndicator()))
            else if (state.error != null)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final currentCategory = widget.category;
                          if (currentCategory != null) {
                            _fetchEvents(currentCategory.link);
                          }
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              )
            else if (state.events.isEmpty)
              const Expanded(child: Center(child: CupertinoActivityIndicator()))
            else
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    final currentCategory = widget.category;
                    if (currentCategory != null) {
                      await _fetchEvents(currentCategory.link);
                    }
                  },
                  child:
                      isGridView
                          ? GridView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            itemCount: state.events.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 1.2,
                                ),
                            itemBuilder: (context, index) {
                              return EventGridWidget(data: state.events[index]);
                            },
                          )
                          : ListView.separated(
                            itemCount: state.events.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(height: 30),
                            itemBuilder: (context, index) {
                              return EventWidget(data: state.events[index]);
                            },
                          ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
