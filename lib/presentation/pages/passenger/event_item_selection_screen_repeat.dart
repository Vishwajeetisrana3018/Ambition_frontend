import 'package:ambition_delivery/data/models/repeat_job_model.dart';
import 'package:ambition_delivery/domain/entities/item.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_event.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:uuid/uuid.dart';

class EventItemSelectionScreenRepeat extends StatefulWidget {
  const EventItemSelectionScreenRepeat({super.key, required this.repeatJob});
  final RepeatJobModel repeatJob;

  @override
  State<EventItemSelectionScreenRepeat> createState() =>
      _EventItemSelectionScreenRepeatState();
}

class _EventItemSelectionScreenRepeatState
    extends State<EventItemSelectionScreenRepeat> {
  final Uuid uuid = const Uuid();
  late bool isRideAndMoveType;
  final TextEditingController _specialRequirementsController =
      TextEditingController();
  final controller = MultiSelectController<Item>();
  final jobTypeController = MultiSelectController<String>();
  Map<Item, int> selectedItemsWithQuantity = {};
  int peopleCount = 0;
  int passengersCount = 0;
  int requiredHelpers = 0;
  int pickupFloor = 0;
  int dropoffFloor = 0;
  List<Item> initialItems = [
    Item(
      id: '1',
      name: 'Extra Small',
      length: 0.3,
      width: 0.3,
      height: 0.3,
      weight: 20,
    ),
    Item(
      id: '2',
      name: 'Small',
      length: 0.5,
      width: 0.5,
      height: 0.5,
      weight: 25,
    ),
    Item(
      id: '3',
      name: 'Medium',
      length: 1.2,
      width: 1.2,
      height: 1.2,
      weight: 35,
    ),
    Item(
      id: '4',
      name: 'Medium +',
      length: 1.9,
      width: 1.9,
      height: 1.9,
      weight: 100,
    ),
    Item(
      id: '5',
      name: 'Large',
      length: 2.5,
      width: 2.5,
      height: 2.5,
      weight: 150,
    ),
    Item(
      id: '6',
      name: 'Extra Large',
      length: 2.6,
      width: 2.6,
      height: 2.6,
      weight: 151,
    ),
  ];

  // Method to handle selection changes and update the selected items with quantity map
  void _onSelectionChange(List<Item> selectedItems) {
    setState(() {
      selectedItemsWithQuantity.clear();
      for (var item in selectedItems) {
        selectedItemsWithQuantity[item] = 1; // Initialize with quantity 1
      }
    });
  }

  // Method to increase the quantity of an item
  void _increaseQuantity(Item item) {
    setState(() {
      selectedItemsWithQuantity[item] =
          (selectedItemsWithQuantity[item] ?? 1) + 1;
    });
  }

  // Method to decrease the quantity of an item (min of 1)
  void _decreaseQuantity(Item item) {
    setState(() {
      if (selectedItemsWithQuantity[item]! > 1) {
        selectedItemsWithQuantity[item] = selectedItemsWithQuantity[item]! - 1;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    isRideAndMoveType = widget.repeatJob.moveType == 'ride & move';
    if (widget.repeatJob.customItems.isNotEmpty) {
      selectedItemsWithQuantity = widget.repeatJob.customItems
          .map((e) => Item(
                id: uuid.v4(),
                name: e.name,
                length: e.length,
                width: e.width,
                height: e.height,
                weight: e.weight,
              ))
          .toList()
          .asMap()
          .map((key, value) =>
              MapEntry(value, widget.repeatJob.customItems[key].quantity));
    }
    peopleCount = widget.repeatJob.peopleTagging;
    requiredHelpers = widget.repeatJob.requiredHelpers;
    pickupFloor = widget.repeatJob.pickupFloor;
    dropoffFloor = widget.repeatJob.dropoffFloor;
    passengersCount = widget.repeatJob.passengersCount ?? 0;
    _specialRequirementsController.text = widget.repeatJob.specialRequirements;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Select Item'),
          backgroundColor: Colors.grey[100],
          scrolledUnderElevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // MultiDropdown for item selection
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: MultiDropdown<Item>(
                          items: initialItems
                              .map((e) =>
                                  DropdownItem<Item>(label: e.name, value: e))
                              .toList(),
                          controller: controller,
                          enabled: true,
                          searchEnabled: true,
                          chipDecoration: const ChipDecoration(
                            backgroundColor: Colors.yellow,
                            wrap: true,
                            runSpacing: 2,
                            spacing: 10,
                          ),
                          fieldDecoration: FieldDecoration(
                            backgroundColor: Colors.white,
                            labelText: 'Items',
                            hintText: 'Select items',
                            hintStyle: const TextStyle(color: Colors.black87),
                            prefixIcon: const Icon(CupertinoIcons.search),
                            showClearIcon: false,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          dropdownDecoration: const DropdownDecoration(
                            marginTop: 2,
                            maxHeight: 500,
                            header: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                'Select Items',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          dropdownItemDecoration: DropdownItemDecoration(
                            selectedIcon: const Icon(Icons.check_box,
                                color: Colors.green),
                            disabledIcon:
                                Icon(Icons.lock, color: Colors.grey.shade300),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select at least one item';
                            }
                            return null;
                          },
                          onSelectionChange: _onSelectionChange,
                          selectedItemBuilder: (item) {
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // List of selected items with quantity control
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'My Items',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            children:
                                selectedItemsWithQuantity.entries.map((entry) {
                              final item = entry.key;
                              final quantity = entry.value;

                              return ListTile(
                                title: Text(item.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle,
                                          color: Colors.black, size: 30),
                                      onPressed: () => _decreaseQuantity(item),
                                    ),
                                    Text('$quantity',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.add_circle,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      onPressed: () => _increaseQuantity(item),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                if (isRideAndMoveType) ...[
                  // People tagging along counter

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              'Car Passengers',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text('Passengers count: ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                IconButton(
                                  icon: const Icon(Icons.remove_circle,
                                      color: Colors.black, size: 30),
                                  onPressed: () {
                                    setState(() {
                                      passengersCount = passengersCount > 0
                                          ? passengersCount - 1
                                          : 0;
                                    });
                                  },
                                ),
                                Text('$passengersCount',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      passengersCount = passengersCount < 8
                                          ? passengersCount + 1
                                          : 8;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                // Extras

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Extras',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        // People tagging along counter
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text('People tagging along: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.black, size: 30),
                                onPressed: () {
                                  setState(() {
                                    peopleCount =
                                        peopleCount > 0 ? peopleCount - 1 : 0;
                                  });
                                },
                              ),
                              Text('$peopleCount',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    peopleCount =
                                        peopleCount + requiredHelpers < 5
                                            ? peopleCount + 1
                                            : peopleCount;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        // Helpers required counter
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text('Helpers required: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.black, size: 30),
                                onPressed: () {
                                  setState(() {
                                    requiredHelpers = requiredHelpers < 2 &&
                                            peopleCount + requiredHelpers < 5
                                        ? requiredHelpers + 1
                                        : requiredHelpers;
                                  });
                                },
                              ),
                              Text('$requiredHelpers',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    requiredHelpers = requiredHelpers < 2 &&
                                            requiredHelpers + peopleCount < 5
                                        ? requiredHelpers + 1
                                        : 2;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Pickup floor counter
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text('Pickup floor: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.black, size: 30),
                                onPressed: () {
                                  setState(() {
                                    pickupFloor =
                                        pickupFloor > -1 ? pickupFloor - 1 : -1;
                                  });
                                },
                              ),
                              Text(
                                  '${pickupFloor == -1 ? 'B' : pickupFloor == 0 ? 'G' : pickupFloor}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    pickupFloor =
                                        pickupFloor < 40 ? pickupFloor + 1 : 40;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        // Dropoff floor counter
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Text('Dropoff floor: ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.remove_circle,
                                    color: Colors.black, size: 30),
                                onPressed: () {
                                  setState(() {
                                    dropoffFloor = dropoffFloor > -1
                                        ? dropoffFloor - 1
                                        : -1;
                                  });
                                },
                              ),
                              Text(
                                  '${dropoffFloor == -1 ? 'B' : dropoffFloor == 0 ? 'G' : dropoffFloor}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(
                                  Icons.add_circle,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  setState(() {
                                    dropoffFloor = dropoffFloor < 40
                                        ? dropoffFloor + 1
                                        : 40;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Special requirements
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Text(
                            'Special Requirements',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _specialRequirementsController,
                            decoration: const InputDecoration(
                              labelText: 'Special Requirements',
                              hintText: 'Special Requirements',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Proceed button
                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: BlocConsumer<RepeatJobBloc, RepeatJobState>(
                          listener: (context, state) {
                        if (state is RepeatJobCreated) {
                        } else if (state is RepeatJobError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }, builder: (context, state) {
                        if (state is RepeatJobLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.favorite,
                                color: Colors.black,
                              ),
                              TextButton(
                                onPressed: () {
                                  if (selectedItemsWithQuantity.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please select at least one item'),
                                      ),
                                    );
                                    return;
                                  }

                                  if (isRideAndMoveType &&
                                      passengersCount == 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please select at least one passenger'),
                                      ),
                                    );
                                    return;
                                  }

                                  // Filter and transform entries that are NOT in initialItems
                                  final itemsNotInInitial =
                                      selectedItemsWithQuantity.entries
                                          .map((entry) => {
                                                'name': entry.key.name,
                                                'length': entry.key.length,
                                                'width': entry.key.width,
                                                'height': entry.key.height,
                                                'weight': entry.key.weight,
                                                'quantity': entry.value,
                                              })
                                          .toList();

                                  Map<String, dynamic> repeatJob = {
                                    'items': [],
                                    'customItems': itemsNotInInitial,
                                    'peopleTagging': peopleCount,
                                    'requiredHelpers': requiredHelpers,
                                    'pickupFloor': pickupFloor,
                                    'dropoffFloor': dropoffFloor,
                                    'specialRequirements':
                                        _specialRequirementsController.text,
                                    'jobType': widget.repeatJob.jobType,
                                    'moveType': widget.repeatJob.moveType,
                                    "isRideAndMove": isRideAndMoveType,
                                    "isEventJob": true,
                                    "originLat": widget.repeatJob.originLat,
                                    "originLong": widget.repeatJob.originLong,
                                    "originName": widget.repeatJob.originName,
                                    "originAddress":
                                        widget.repeatJob.originAddress,
                                    "destinationLat":
                                        widget.repeatJob.destinationLat,
                                    "destinationLong":
                                        widget.repeatJob.destinationLong,
                                    "destinationName":
                                        widget.repeatJob.destinationName,
                                    "destinationAddress":
                                        widget.repeatJob.destinationAddress,
                                    if (isRideAndMoveType)
                                      "passengersCount": passengersCount,
                                  };

                                  context
                                      .read<RepeatJobBloc>()
                                      .add(CreateRepeatJobEvent(repeatJob));
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            if (selectedItemsWithQuantity.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Please select at least one item'),
                                ),
                              );
                              return;
                            }

                            if (isRideAndMoveType && passengersCount == 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please select at least one passenger'),
                                ),
                              );
                              return;
                            }

                            // Filter and transform entries that are NOT in initialItems
                            final itemsNotInInitial =
                                selectedItemsWithQuantity.entries
                                    .map((entry) => {
                                          'name': entry.key.name,
                                          'length': entry.key.length,
                                          'width': entry.key.width,
                                          'height': entry.key.height,
                                          'weight': entry.key.weight,
                                          'quantity': entry.value,
                                        })
                                    .toList();

                            Navigator.of(context).pushNamed(
                              '/vehicle_category_selection',
                              arguments: {
                                'items': [],
                                'customItems': itemsNotInInitial,
                                'peopleTagging': peopleCount,
                                'requiredHelpers': requiredHelpers,
                                'pickupFloor': pickupFloor,
                                'dropoffFloor': dropoffFloor,
                                'specialRequirements':
                                    _specialRequirementsController.text,
                                'jobType': widget.repeatJob.jobType,
                                'moveType': widget.repeatJob.moveType,
                                "isRideAndMove": isRideAndMoveType,
                                "isEventJob": true,
                                "originLat": widget.repeatJob.originLat,
                                "originLong": widget.repeatJob.originLong,
                                "originName": widget.repeatJob.originName,
                                "originAddress": widget.repeatJob.originAddress,
                                "destinationLat":
                                    widget.repeatJob.destinationLat,
                                "destinationLong":
                                    widget.repeatJob.destinationLong,
                                "destinationName":
                                    widget.repeatJob.destinationName,
                                "destinationAddress":
                                    widget.repeatJob.destinationAddress,
                                if (isRideAndMoveType)
                                  "passengersCount": passengersCount,
                              },
                            );
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
