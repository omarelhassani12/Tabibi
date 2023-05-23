import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tabibi/utils/theme.dart';

class AppointmentForm extends StatefulWidget {
  const AppointmentForm({Key? key}) : super(key: key);

  @override
  _AppointmentFormState createState() => _AppointmentFormState();
}

class _AppointmentFormState extends State<AppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  late DateTime _selectedDate = DateTime.now();
  late TimeOfDay _selectedTime = TimeOfDay.now();
  late String _selectedType = 'Check-up (examen de routine)';
  final bool _isFullAppointment = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      // lastDate: DateTime.now().add(Duration(days: 365 * 1000)),
      lastDate: DateTime(9999, 12, 31),
      selectableDayPredicate: (DateTime date) {
        return date.weekday >= 1 && date.weekday <= 5;
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _selectedTime = selectedTime;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Prendre rendez-vous'),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Détails du patient',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: mainColor,
                    ),
              ),
              TextFormField(
                initialValue: 'Patient name',
                decoration: InputDecoration(
                  labelText: 'Nom complet',
                  // hintText: 'Enter your full name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                enabled: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                // controller: _emailController,
                initialValue: 'Patient@gmail.com',

                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                //if u want tto make the input read only
                enabled: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!value.contains('@') || !value.contains('.')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                // controller: _phoneController,
                initialValue: '0666666666',

                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Numéro de téléphone',
                  hintText: 'Enter your phone number',
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                enabled: false,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.length < 10) {
                    return 'Phone number must be at least 10 digits long';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 36.0),
              Text(
                'Détails du rendez-vous',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: mainColor,
                    ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'rendez-vous Type',
                  labelStyle: TextStyle(color: Colors.grey[400]),
                  hintText: 'Sélectionnez un type de rendez-vous',
                ),
                value: _selectedType,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedType = newValue;
                    });
                  }
                },
                items: <String>[
                  "Check-up (examen de routine)",
                  "Nettoyage dentaire",
                  "Obturation dentaire (plombage)",
                  "Extraction dentaire",
                  "Traitement endodontique (dévitalisation)",
                  "Pose de couronne dentaire",
                  "Pose d'appareil dentaire (orthodontie)",
                  "Blanchiment dentaire",
                  "Prothèse dentaire",
                  "Implant dentaire"
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.calendar_today, color: mainColor),
                title: Text(
                  (_selectedDate == DateTime(0))
                      ? 'Sélectionnez la date du rendez-vous'
                      : DateFormat.yMMMd().format(_selectedDate),
                  style: TextStyle(color: mainColor),
                ),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.alarm, color: mainColor),
                title: Text(
                  _selectedTime == null
                      ? 'Sélectionnez l\'heure du rendez-vous'
                      : _selectedTime.format(context),
                  style: TextStyle(color: mainColor),
                ),
                onTap: () {
                  _selectTime(context);
                },
                subtitle: const Text(
                  'Heures disponibles : de 9h00 à 17h00',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Veuillez sélectionner une date'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if ((_selectedTime.hour < 9 ||
                          _selectedTime.hour > 17)) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Row(
                              children: [
                                Text('Heures disponibles : de 9h00 à 17h00'),
                                SizedBox(
                                    width:
                                        25), // Add some space between the icon and text
                                Icon(
                                  Icons.warning,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                        // ignore: unnecessary_null_comparison
                      } else if (_selectedTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Veuillez sélectionner une heure'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Row(
                              children: [
                                Text('Rendez-vous réservé !'),
                                SizedBox(width: 25),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            backgroundColor: mainColor,
                          ),
                        );
                      }
                    } else if (_selectedTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Veuillez sélectionner une heure'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                  ),
                  child: const Text('Prendre rendez-vous'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
