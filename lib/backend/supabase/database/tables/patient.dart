import '../database.dart';

class PatientTable extends SupabaseTable<PatientRow> {
  @override
  String get tableName => 'patient';

  @override
  PatientRow createRow(Map<String, dynamic> data) => PatientRow(data);
}

class PatientRow extends SupabaseDataRow {
  PatientRow(super.data);

  @override
  SupabaseTable get table => PatientTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  String get name => getField<String>('name')!;
  set name(String value) => setField<String>('name', value);

  DateTime? get dateOfBirth => getField<DateTime>('date_of_birth');
  set dateOfBirth(DateTime? value) =>
      setField<DateTime>('date_of_birth', value);

  bool? get isNewPatient => getField<bool>('is_new_patient');
  set isNewPatient(bool? value) => setField<bool>('is_new_patient', value);

  String? get symptoms => getField<String>('symptoms');
  set symptoms(String? value) => setField<String>('symptoms', value);

  String? get diagnosis => getField<String>('diagnosis');
  set diagnosis(String? value) => setField<String>('diagnosis', value);
}
