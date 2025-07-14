import 'dart:developer';

import 'package:ambition_delivery/data/models/repeat_job_item_model.dart';
import 'package:ambition_delivery/data/models/repeat_job_model.dart';
import 'package:ambition_delivery/domain/entities/item.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_bloc.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_event.dart';
import 'package:ambition_delivery/presentation/bloc/repeat_job_state.dart';
import 'package:ambition_delivery/presentation/bloc/ride_request_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class ItemSelectionScreenRepeat extends StatefulWidget {
  const ItemSelectionScreenRepeat({
    super.key,
    required this.repeatJob,
  });
  final RepeatJobModel repeatJob;

  @override
  State<ItemSelectionScreenRepeat> createState() =>
      _ItemSelectionScreenRepeatState();
}

class _ItemSelectionScreenRepeatState extends State<ItemSelectionScreenRepeat> {
  late bool isRideAndMoveType;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
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
  List<Item> initialItems = [];

  @override
  void initState() {
    isRideAndMoveType = widget.repeatJob.moveType == 'ride & move';

    peopleCount = widget.repeatJob.peopleTagging;
    requiredHelpers = widget.repeatJob.requiredHelpers;
    pickupFloor = widget.repeatJob.pickupFloor;
    dropoffFloor = widget.repeatJob.dropoffFloor;
    passengersCount = widget.repeatJob.passengersCount ?? 0;
    _specialRequirementsController.text = widget.repeatJob.specialRequirements;

    BlocProvider.of<RideRequestBloc>(context).add(GetItems());
    super.initState();
  }

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
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        //Remove till the first screen
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
        body: BlocConsumer<RideRequestBloc, RideRequestState>(
          listener: (context, state) {
            if (state is RideRequestError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ItemsLoaded) {
              for (var item in widget.repeatJob.items) {
                log('Item: ${RepeatJobItemModel.fromEntity(item).toJson()}');
                var matchedItem =
                    state.items.firstWhere((element) => element.id == item.id);

                // Since we've overridden == and hashCode, this will prevent duplicates based on id
                selectedItemsWithQuantity[matchedItem] = item.quantity;
              }
              setState(() {});
            }
          },
          builder: (context, state) {
            if (state is RideRequestLoading || state is RideRequestInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ItemsLoaded) {
              initialItems = state.items;

              return SingleChildScrollView(
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
                                items: state.items
                                    .map((e) => DropdownItem<Item>(
                                        label: e.name, value: e))
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
                                  hintStyle:
                                      const TextStyle(color: Colors.black87),
                                  prefixIcon: const Icon(CupertinoIcons.search),
                                  showClearIcon: false,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                        const BorderSide(color: Colors.grey),
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
                                  disabledIcon: Icon(Icons.lock,
                                      color: Colors.grey.shade300),
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
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                // Add a new item to the item list
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Add New Item'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            controller: _nameController,
                                            decoration: const InputDecoration(
                                              labelText: 'Name',
                                            ),
                                          ),
                                          TextField(
                                            controller: _lengthController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: 'Length',
                                            ),
                                          ),
                                          TextField(
                                            controller: _widthController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: 'Width',
                                            ),
                                          ),
                                          TextField(
                                            controller: _heightController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: 'Height',
                                            ),
                                          ),
                                          TextField(
                                            controller: _weightController,
                                            keyboardType: TextInputType.number,
                                            decoration: const InputDecoration(
                                              labelText: 'Weight',
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            _nameController.clear();
                                            _lengthController.clear();
                                            _widthController.clear();
                                            _heightController.clear();
                                            _weightController.clear();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            final name = _nameController.text;
                                            final length = double.tryParse(
                                                    _lengthController.text) ??
                                                0;
                                            final width = double.tryParse(
                                                    _widthController.text) ??
                                                0;
                                            final height = double.tryParse(
                                                    _heightController.text) ??
                                                0;
                                            final weight = double.tryParse(
                                                    _weightController.text) ??
                                                0;

                                            if (name.isEmpty ||
                                                length == 0 ||
                                                width == 0 ||
                                                height == 0 ||
                                                weight == 0) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Please fill all fields'),
                                                ),
                                              );
                                              return;
                                            } else {
                                              controller.items
                                                  .add(DropdownItem<Item>(
                                                label: name,
                                                value: Item(
                                                  id: "${controller.items.length + 1}",
                                                  name: name,
                                                  length: length,
                                                  width: width,
                                                  height: height,
                                                  weight: weight,
                                                ),
                                              ));
                                              _nameController.clear();
                                              _lengthController.clear();
                                              _widthController.clear();
                                              _heightController.clear();
                                              _weightController.clear();
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text('Add'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.add_circle,
                                color: Colors.black,
                                size: 30,
                              ),
                            )
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                  children: selectedItemsWithQuantity.entries
                                      .map((entry) {
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
                                            icon: const Icon(
                                                Icons.remove_circle,
                                                color: Colors.black,
                                                size: 30),
                                            onPressed: () =>
                                                _decreaseQuantity(item),
                                          ),
                                          Text('$quantity',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.add_circle,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                            onPressed: () =>
                                                _increaseQuantity(item),
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
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
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
                                            passengersCount =
                                                passengersCount > 0
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
                                            passengersCount =
                                                passengersCount < 8
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

                      //Extras

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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
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
                                          peopleCount = peopleCount > 0
                                              ? peopleCount - 1
                                              : 0;
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
                                          requiredHelpers = requiredHelpers > 0
                                              ? requiredHelpers - 1
                                              : 0;
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
                                          requiredHelpers =
                                              requiredHelpers < 2 &&
                                                      peopleCount +
                                                              requiredHelpers <
                                                          5
                                                  ? requiredHelpers + 1
                                                  : requiredHelpers;
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
                                          pickupFloor = pickupFloor > -1
                                              ? pickupFloor - 1
                                              : -1;
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
                                          pickupFloor = pickupFloor < 40
                                              ? pickupFloor + 1
                                              : 40;
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
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Please select at least one item'),
                                            ),
                                          );
                                          return;
                                        }

                                        if (isRideAndMoveType &&
                                            passengersCount == 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  'Please select at least one passenger'),
                                            ),
                                          );
                                          return;
                                        }

                                        final initialItemIds = initialItems
                                            .map((e) => e.id)
                                            .toSet();
                                        // Filter and transform entries that are in initialItems
                                        final itemsInInitial =
                                            selectedItemsWithQuantity.entries
                                                .where((entry) => initialItemIds
                                                    .contains(entry.key.id))
                                                .map((entry) => {
                                                      'id': entry.key.id,
                                                      'quantity': entry.value,
                                                    })
                                                .toList();

                                        // Filter and transform entries that are NOT in initialItems
                                        final itemsNotInInitial =
                                            selectedItemsWithQuantity.entries
                                                .where((entry) =>
                                                    !initialItemIds
                                                        .contains(entry.key.id))
                                                .map((entry) => {
                                                      'name': entry.key.name,
                                                      'length':
                                                          entry.key.length,
                                                      'width': entry.key.width,
                                                      'height':
                                                          entry.key.height,
                                                      'weight':
                                                          entry.key.weight,
                                                      'quantity': entry.value,
                                                    })
                                                .toList();
                                        Map<String, dynamic> repeatJob = {
                                          'items': itemsInInitial,
                                          'customItems': itemsNotInInitial,
                                          'peopleTagging': peopleCount,
                                          'requiredHelpers': requiredHelpers,
                                          'pickupFloor': pickupFloor,
                                          'dropoffFloor': dropoffFloor,
                                          'specialRequirements':
                                              _specialRequirementsController
                                                  .text,
                                          'jobType': widget.repeatJob.jobType,
                                          'moveType': widget.repeatJob.moveType,
                                          "isRideAndMove": isRideAndMoveType,
                                          "isEventJob": false,
                                          "originLat":
                                              widget.repeatJob.originLat,
                                          "originLong":
                                              widget.repeatJob.originLong,
                                          "originName":
                                              widget.repeatJob.originName,
                                          "originAddress":
                                              widget.repeatJob.originAddress,
                                          "destinationLat":
                                              widget.repeatJob.destinationLat,
                                          "destinationLong":
                                              widget.repeatJob.destinationLong,
                                          "destinationName":
                                              widget.repeatJob.destinationName,
                                          "destinationAddress": widget
                                              .repeatJob.destinationAddress,
                                          if (isRideAndMoveType)
                                            "passengersCount": passengersCount,
                                        };

                                        context.read<RepeatJobBloc>().add(
                                            CreateRepeatJobEvent(repeatJob));
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

                                  final initialItemIds =
                                      initialItems.map((e) => e.id).toSet();
                                  // Filter and transform entries that are in initialItems
                                  final itemsInInitial =
                                      selectedItemsWithQuantity.entries
                                          .where((entry) => initialItemIds
                                              .contains(entry.key.id))
                                          .map((entry) => {
                                                'id': entry.key.id,
                                                'quantity': entry.value,
                                              })
                                          .toList();

                                  // Filter and transform entries that are NOT in initialItems
                                  final itemsNotInInitial =
                                      selectedItemsWithQuantity.entries
                                          .where((entry) => !initialItemIds
                                              .contains(entry.key.id))
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
                                      'items': itemsInInitial,
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
                                      "isEventJob": false,
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
              );
            } else if (state is RideRequestError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('An error occurred'),
              );
            }
          },
        ),
      ),
    );
  }
}
