import 'package:flavoring_flavorizr/data/data.dart';
import 'package:flavoring_flavorizr/models/preference.dart';
import 'package:flavoring_flavorizr/ui/widgets/custom_icon_botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

typedef FunctionCallback = void Function(List<Preference> value);

class PickPreferencesDialog extends ModalRoute<void> {
  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  final FunctionCallback onPressBotton;

  PickPreferencesDialog({required this.onPressBotton});

  //TODO: cambiar por Set
  List<Preference> preferencesSelected = [];

  addPreferenceSelected(Preference pref) => preferencesSelected.add(pref);

  removePreferenceSelected(Preference pref) => preferencesSelected.removeWhere(
        (prefer) => prefer.id == pref.id,
      );

  isPreferenceSelected(Preference pref) => preferencesSelected.any(
        (prefer) => prefer.id == pref.id,
      );

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 100.0,
                bottom: 100.0,
                left: 20,
                right: 20,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60.0),
                        child: Text(
                          'title',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 15.0),
                        child: Text(
                          'message',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.black ?? Colors.grey),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, top: 15.0, right: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 300,
                            child: Scrollbar(
                              thumbVisibility: true,
                              trackVisibility: true,
                              interactive: true,
                              radius: Radius.circular(20),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                ),
                                itemCount: DataSheet().data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CustomIconBotton(
                                      isSelected: isPreferenceSelected(
                                          DataSheet().data[index]),
                                      onTap: () {
                                        setState(() {
                                          if (isPreferenceSelected(
                                              DataSheet().data[index])) {
                                            removePreferenceSelected(
                                                DataSheet().data[index]);
                                          } else {
                                            addPreferenceSelected(
                                                DataSheet().data[index]);
                                          }
                                          print(preferencesSelected.length);
                                        });
                                      },
                                      label: 'aaaa',
                                      color: '#4BF173',
                                      filter: () {},
                                      iconPath:
                                          DataSheet().data[index].iconUrl ??
                                              '');
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          top: 15.0,
                        ),
                        child: ElevatedButton(
                          onPressed: preferencesSelected.isEmpty
                              ? null
                              : () {
                                  onPressBotton(preferencesSelected);
                                  Navigator.pop(context);
                                },
                          child: preferencesSelected.isEmpty
                              ? Text('Selecione almenos 1')
                              : Text('Enviar'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
