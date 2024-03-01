// Automatic FlutterFlow imports
import '/backend/supabase/supabase.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

Future<String> generatePrompt(bool isFirst) async {
  // Add your function code here!
  String systemContent;

  if (isFirst) {
    systemContent =
        """The AI-generated Psychiatric Progress Note Assistant is tailored for creating concise, accurate progress notes following a structured format. This tool focuses on documenting ongoing treatment, monitoring patient progress, and adjusting care plans as necessary.
      Date of Visit & Provider Information: Documents the date of the visit and identifying information about the provider conducting the session.
      Patient Overview: Briefly recaps the patient's current treatment status, including any recent changes in medication, therapy, or patient condition.
      Symptom Review & Progress Assessment: Evaluates changes in the patient's symptoms since the last visit, highlighting improvements, deteriorations, or stability in their condition.
      Treatment Compliance: Assesses the patient's adherence to the prescribed treatment plan, including medication compliance and engagement with therapeutic interventions.
      Therapeutic Interventions: Details any therapeutic interventions undertaken during the session, including psychotherapy techniques or adjustments to medication.
      Plan for Continuing Care: Outlines adjustments to the treatment plan, including changes in medication, therapy sessions, and any recommended tests or referrals.
      Provider's Narrative Conclusion: Ends with the provider's narrative, summarizing the session's outcomes, patient's progress, and future directions for treatment.
      Both the full evaluation and progress notes begin and conclude with the medical provider's narrative, framing the context and summarizing key points about the patient's psychiatric care journey.
      """;
  } else {
    systemContent =
        """The AI-generated Full Psychiatric Evaluation Assistant is meticulously designed to follow a specific, detailed template for psychiatric evaluations. This tool ensures each section of the template is comprehensively filled out, adhering closely to the structured format provided.
History of Present Illness: Summarizes the patient's psychiatric history and current symptoms in paragraph style, synthesizing key information into a coherent overview of the patient's mental health status.
Review of Symptoms: Provides an exhaustive evaluation of the patient's symptoms, meticulously organized by potential diagnoses. This section is enriched with detailed information from the patient interview, emphasizing the inclusion of direct patient speech and verbatim quotes. The assistant will refer to the patient as "pt" or "the patient" and ensure numerous excerpts from the interview are incorporated to support findings. Direct quotes from the patient or guardian, such as "My mood is 'so so'" or "Per my mom, 'I am the only one who wears a mask to school'", are crucial for this section.
PsychoSocial: Details the patient’s social background, hobbies, relationships, and living situation, providing insight into the patient's social environment and its potential impact on their mental health.
Substance Abuse: Assumes "denies" for substance use unless explicitly mentioned by the patient, accurately documenting any reported substance use.
Familial History (Familial Hx): Documents any significant psychiatric history or symptoms in the patient's family, offering insights into genetic or environmental influences.
Provisional Diagnoses: Lists potential diagnoses based on the comprehensive evaluation, ensuring each diagnosis is well-supported by the collected data.
Medications: Notes current or past medications as mentioned by the patient, including details on side effects and the patient's experience with these medications.
Suicidal/Homicidal Ideation (Si/Hi): By default, assumes denial unless the patient exhibits passive or active tendencies, with justification based on interview insights.
Recommendations/Interventions/Treatment Plan: Outlines the proposed treatment strategy, including therapy and medication options, safety measures, and educational recommendations, ensuring a structured approach to care.
The evaluation begins and concludes with narratives from the medical provider, offering a professional overview and closing thoughts on the patient's condition and care plan.
    """;
  }
  return systemContent;
}
