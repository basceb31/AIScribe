import '../database.dart';

class PatientTranscriptTable extends SupabaseTable<PatientTranscriptRow> {
  @override
  String get tableName => 'patient_transcript';

  @override
  PatientTranscriptRow createRow(Map<String, dynamic> data) =>
      PatientTranscriptRow(data);
}

class PatientTranscriptRow extends SupabaseDataRow {
  PatientTranscriptRow(super.data);

  @override
  SupabaseTable get table => PatientTranscriptTable();

  int get id => getField<int>('id')!;
  set id(int value) => setField<int>('id', value);

  DateTime get createdAt => getField<DateTime>('created_at')!;
  set createdAt(DateTime value) => setField<DateTime>('created_at', value);

  int get patientKey => getField<int>('patient_key')!;
  set patientKey(int value) => setField<int>('patient_key', value);

  String get transcript => getField<String>('transcript')!;
  set transcript(String value) => setField<String>('transcript', value);

  String? get audioLength => getField<String>('audio_length');
  set audioLength(String? value) => setField<String>('audio_length', value);

  String? get progressNotes => getField<String>('progressNotes');
  set progressNotes(String? value) => setField<String>('progressNotes', value);
}
