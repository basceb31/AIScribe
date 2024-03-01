// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:supabase/supabase.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';

Future transcribeAndUpload(
    String audioPath, int patientId, bool isNewPatient) async {
  // get recorded audio from stop recording audio then read as raw for api call
  // First, stop recording audio

  // Then, read the recorded audio as raw data
  final file = File(audioPath);
  final bytes = await file.readAsBytes();

  // final player = AudioPlayer();
  // await player.setSource(AssetSource(audioPath));
  // int milliseconds = player.getDuration()
  // int seconds = (milliseconds / 1000).round();
  // int minutes = seconds ~/ 60;
  // seconds = seconds % 60;
  // String durationString = '$minutes:${seconds.toString().padLeft(2, '0')}';

  // Finally, make the API call with the raw audio data
  var url = Uri.parse(
      'https://api.deepgram.com/v1/listen?smart_format=true&paragraphs=true&diarize=true&language=en&model=nova-2');
  var apiKey = 'dd49d2a665759894717c2211e4390de580d32dcd';

  // Set up the headers for the request
  var headers = {
    'Authorization': 'Token ' + apiKey,
    'Content-Type': 'audio/wav'
  };
  var response = await http.post(url, headers: headers, body: bytes);

  // Check for errors in the response
  if (response.statusCode != 200) {
    throw Exception("Failed to upload audio: ${response.reasonPhrase}");
  }

  // Parse the JSON response
  var jsonResponse = json.decode(response.body);

  // Access the transcript
  var transcript = jsonResponse['results']['channels'][0]['alternatives'][0]
      ['paragraphs']['transcript'];

  final SupabaseClient supabase = SupabaseClient(
      'https://xdmphmvjlqojaanhcwoq.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhkbXBobXZqbHFvamFhbmhjd29xIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDg0ODk0NjksImV4cCI6MjAyNDA2NTQ2OX0.gstLqW8xlJURVHwwyH4i_Gw6VY9ZUqhlo3KlcZZiDJc');

  // Insert the transcript into the Supabase 'patient_transcript' table
  final Map<String, dynamic> insertResponse = await supabase
      .from('patient_transcript')
      .insert({
        'patient_key': patientId, //TODO: change to dynamic value
        'transcript': transcript,
        // 'audio_length': durationString
      })
      .select()
      .single();

  await generateProgressNotes(insertResponse['id'], transcript, isNewPatient);

  if (isNewPatient) {
    supabase.from('patient').update({
      'is_new_patient': false,
    }).match({'id': patientId}).select();
  }
  // Check for errors in the insert operation
  // if (insertResponse.error != null) {
  //   throw Exception(
  //       "Failed to insert transcript: ${insertResponse.error.message}");
  // }

  return insertResponse['id'];
}
