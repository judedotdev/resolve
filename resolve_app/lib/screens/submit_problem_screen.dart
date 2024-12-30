// submit_problem_screen.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resolve_app/services/auth_service.dart';

class SubmitProblemScreen extends StatefulWidget {
  const SubmitProblemScreen({super.key});

  @override
  State<SubmitProblemScreen> createState() => _SubmitProblemScreenState();
}

class _SubmitProblemScreenState extends State<SubmitProblemScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for user inputs
  final TextEditingController _problemTitleController = TextEditingController();
  final TextEditingController _problemDescriptionController =
      TextEditingController();
  final TextEditingController _impactDescriptionController =
      TextEditingController();
  final TextEditingController _proposedSolutionController =
      TextEditingController();
  final TextEditingController _surveyAnswersController =
      TextEditingController();

  bool _allowContact = false;
  bool _makePublic = false;

  // Dropdown options
  String? _selectedIncentive;
  final List<String> _incentives = [
    'Cash prizes',
    'Community recognition',
    'Skill-building opportunities',
  ];

  final AuthService _authService = AuthService(); // Instance of AuthService
  bool _isLoading = false;
  String? _errorMessage;

  // function to Check network connectivity (prod)
  Future<bool> _isNetworkConnected() async {
    try {
      final response = await http.get(Uri.parse('https://www.google.com'));

      // If the response status is OK, then internet is available
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void _submitProblem(BuildContext context) async {
    final problemData = {
      "title": _problemTitleController.text,
      "problemDescription": _problemDescriptionController.text,
      "impactDescription": _impactDescriptionController.text,
      "suggestedSolution": _proposedSolutionController.text,
      "selectedIncentive": _selectedIncentive,
      "extraInfo": _surveyAnswersController.text,
      "allowContact": _allowContact,
      "makePublic": _makePublic,
    };

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Check network connectivity: comment this block if you used dev `_baseUrl`
    final isConnected = await _isNetworkConnected();
    if (!isConnected && context.mounted) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text("No internet connection. Please check your network."),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 5),
        ),
      );
      return;
    }
    // END Check network connectivity

    // Attempt to submit problem
    final response = await _authService.submitProblem(problemData);

    setState(() {
      _isLoading = false;
    });

    if (response["success"] == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Problem submitted successfully!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 5),
        ),
      );
      _formKey.currentState!.reset();
      _problemTitleController.clear();
      _problemDescriptionController.clear();
      _impactDescriptionController.clear();
      _proposedSolutionController.clear();
      _surveyAnswersController.clear();
      setState(() {
        _selectedIncentive = null;
        _allowContact = false;
        _makePublic = false;
      });
    } else {
      setState(() {
        _errorMessage = response['message'];
      });

      // Show the error message in a SnackBar
      if (_errorMessage != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Submission failed: ${_errorMessage!}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  // Helper method for survey questions
  Widget _buildSurveyQuestion(
      String question, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: 3,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your answer',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submit a Problem'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Problem Title
                Text(
                  'Problem Title:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _problemTitleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'e.g: Smart Waste Management',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a problem title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Problem Description
                Text(
                  'Problem Description:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _problemDescriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                        'What is that challenge in your community that you feel needs immediate attention?',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe the problem';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Impact Description
                Text(
                  'How does this problem impact your community?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _impactDescriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                        'How have these challenges affected your daily life or the well-being of others in your community?',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe the impact';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Proposed Solution
                Text(
                  'Proposed Solution (Optional)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _proposedSolutionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText:
                        'If you could propose a solution to this problem in your community, what would it be, and why?',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Incentive Dropdown
                Text(
                  'What types of incentives would encourage you to participate in solving community problems?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'What Incentive Encourages You?',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedIncentive,
                  items: _incentives.map((incentive) {
                    return DropdownMenuItem(
                      value: incentive,
                      child: Text(incentive),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedIncentive = value;
                    });
                  },
                ),
                SizedBox(height: 16),

                // Survey Questions
                _buildSurveyQuestion(
                  "Is there anything else you'd like to share about your vision for how Resolve Tech can make a positive impact in your community?",
                  _surveyAnswersController,
                ),

                // Checkboxes
                CheckboxListTile(
                  title: Text('Allow Resolve Tech to contact you'),
                  value: _allowContact,
                  onChanged: (value) {
                    setState(() {
                      _allowContact = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: Text('Make this submission public'),
                  value: _makePublic,
                  onChanged: (value) {
                    setState(() {
                      _makePublic = value!;
                    });
                  },
                ),
                SizedBox(height: 20),

                // Submit Button
                _isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _submitProblem(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F41BB),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Submit Problem',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _problemTitleController.dispose();
    _problemDescriptionController.dispose();
    _impactDescriptionController.dispose();
    _proposedSolutionController.dispose();
    _surveyAnswersController.dispose();
    super.dispose();
  }
}
