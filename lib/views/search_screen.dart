import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:real_estate/utils/app_colors.dart';

import '../bloc/search/search_cubit.dart';
import '../enums/search_option.dart';
import '../widgets/search_menu_item_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatefulWidget {
  const _SearchView({super.key});

  @override
  State<_SearchView> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<_SearchView> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String _mapStyle = '';

  static const LatLng _center = LatLng(45.521563, -122.677433);

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: _center,
    zoom: 14.4746,
  );

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('marker_1'),
      position: LatLng(45.521563, -122.677433),
      infoWindow: InfoWindow(
        title: 'First Marker',
        snippet: 'This is the first marker',
      ),
    ),
    const Marker(
      markerId: MarkerId('marker_2'),
      position: LatLng(45.531563, -122.677433),
      infoWindow: InfoWindow(
        title: 'Second Marker',
        snippet: 'This is the second marker',
      ),
    ),
    const Marker(
      markerId: MarkerId('marker_3'),
      position: LatLng(45.541563, -122.677433),
      infoWindow: InfoWindow(
        title: 'Third Marker',
        snippet: 'This is the third marker',
      ),
    ),
  };

  @override
  void initState() {
    super.initState();
    // Load the map style from the JSON file
    DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json')
        .then((String style) {
      setState(() {
        _mapStyle = style;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            mapToolbarEnabled: false,
            zoomControlsEnabled: false,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              controller.setMapStyle(_mapStyle);
            },
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
              child: Row(
                children: [
                  const Expanded(
                    child: RoundedTextField(),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.only(left: 10),
                    width: 60,
                    height: 60,
                    child: const Center(
                      child: Icon(
                        Icons.display_settings_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 30,
            right: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        _showPopupMenu(details.globalPosition);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                        width: 60,
                        height: 60,
                        child: Center(
                          child: BlocBuilder<SearchCubit, SearchState>(
                            builder: (context, state) {
                              final IconData icon;
                              switch (state.searchOption) {
                                case SearchOption.cosyAreas:
                                  icon = Icons.security;
                                  break;
                                case SearchOption.price:
                                  icon = Icons.wallet;
                                  break;
                                case SearchOption.infrastructure:
                                  icon = Icons.restore_from_trash_outlined;
                                  break;
                                case SearchOption.withoutAnyLayer:
                                  icon = Icons.storage;
                                  break;
                              }
                              return Icon(
                                icon,
                                color: Colors.white,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      width: 60,
                      height: 60,
                      child: const Center(
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey.withOpacity(0.6),
                  ),
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.sort_sharp,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'List of variants',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showPopupMenu(Offset offset) async {
    final selectedSearchOption = context.read<SearchCubit>().state.searchOption;

    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    const double menuHeight =
        250; // Adjust this value based on the number of menu items
    await showMenu(
      context: context,
      // position: RelativeRect.fromLTRB(left, top, left+1, top+1),
      position: RelativeRect.fromRect(
        Rect.fromLTWH(offset.dx, offset.dy - menuHeight, 80,
            80), // Adjust position to show above
        Offset.zero & overlay.size,
      ),
      popUpAnimationStyle: AnimationStyle(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      color: AppColors.popupMenuColor,
      items: [
        PopupMenuItem<String>(
          onTap: () {
            context
                .read<SearchCubit>()
                .update(searchOption: SearchOption.cosyAreas);
          },
          value: SearchOption.cosyAreas.name,
          child: SearchMenuItemTile(
            icon: Icons.security,
            name: 'Cosy areas',
            selected: selectedSearchOption == SearchOption.cosyAreas,
          ),
        ),
        PopupMenuItem<String>(
          onTap: () {
            context
                .read<SearchCubit>()
                .update(searchOption: SearchOption.price);
          },
          value: SearchOption.price.name,
          child: SearchMenuItemTile(
            icon: Icons.wallet,
            name: 'Price',
            selected: selectedSearchOption == SearchOption.price,
          ),
        ),
        PopupMenuItem<String>(
          onTap: () {
            context
                .read<SearchCubit>()
                .update(searchOption: SearchOption.infrastructure);
          },
          value: SearchOption.infrastructure.name,
          child: SearchMenuItemTile(
            icon: Icons.restore_from_trash_outlined,
            name: 'Infrastructure',
            selected: selectedSearchOption == SearchOption.infrastructure,
          ),
        ),
        PopupMenuItem<String>(
          onTap: () {
            context
                .read<SearchCubit>()
                .update(searchOption: SearchOption.withoutAnyLayer);
          },
          value: SearchOption.withoutAnyLayer.name,
          child: SearchMenuItemTile(
            icon: Icons.storage,
            name: 'Without any layer',
            selected: selectedSearchOption == SearchOption.withoutAnyLayer,
          ),
        ),
      ],
      elevation: 8.0,
    );
  }
}

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Enter text here',
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide
              .none, // Use BorderSide.none if you don't want a border line
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
