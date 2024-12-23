import 'package:flutter/material.dart';

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
  final TextEditingController _technologyRoleController =
      TextEditingController();
  final TextEditingController _surveyAnswersController =
      TextEditingController();

  bool _technologyCanHelp = false;
  bool _allowContact = false;
  bool _makePublic = false;

  // Dropdown options
  String? _selectedCategory;
  final List<String> _categories = [
    'Health',
    'Environment',
    'Education',
    'Infrastructure',
    'Technology',
  ];

  String? _selectedIncentive;
  final List<String> _incentives = [
    'Cash prizes',
    'Community recognition',
    'Skill-building opportunities',
  ];

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
                TextFormField(
                  controller: _problemTitleController,
                  decoration: InputDecoration(
                    labelText: 'Problem Title',
                    border: OutlineInputBorder(),
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
                TextFormField(
                  controller: _problemDescriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'Problem Description',
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
                TextFormField(
                  controller: _impactDescriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'How does this problem impact your community?',
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
                TextFormField(
                  controller: _proposedSolutionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: 'Proposed Solution (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                // Category Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a category';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Can Technology Help Toggle
                SwitchListTile(
                  title: Text('Can Technology Solve This Problem?'),
                  value: _technologyCanHelp,
                  onChanged: (value) {
                    setState(() {
                      _technologyCanHelp = value;
                    });
                  },
                ),
                if (_technologyCanHelp)
                  TextFormField(
                    controller: _technologyRoleController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'How can technology help?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(height: 16),

                // Incentive Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'What Incentive Encourages You?',
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
                ...[
                  'What are the most pressing challenges in your community that you feel need immediate attention?',
                  'How have these challenges affected your daily life or the well-being of others in your community?',
                  'If you could propose a solution to one major problem in your community, what would it be, and why?',
                  'Do you believe technology can play a significant role in solving these challenges? Why or why not?',
                  'Have you ever participated in a hackathon or similar collaborative problem-solving event? If yes, what was your experience?',
                  'What features would make a mobile app most effective for identifying and solving community problems?',
                  'What motivates you to contribute to community problem-solving?',
                  'How likely are you to use an app that connects individuals to collaboratively solve problems in their communities?',
                  'What types of incentives would encourage you to participate in solving community problems?',
                  'Which age group do you belong to?',
                  'What is your gender?',
                  'What is your current occupation or primary activity?',
                  'What do you think makes an idea or solution innovative and impactful?',
                  'Are there specific challenges in your community that you feel only a collaborative platform like SolveIT Labs can address?',
                  'Is there anything else you’d like to share about your vision for how SolveIT Labs can make a positive impact in your community?'
                ].map((question) {
                  return _buildSurveyQuestion(
                      question, _surveyAnswersController);
                }),

                // Checkboxes
                CheckboxListTile(
                  title: Text('Allow SolveIT Labs to contact you'),
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
                SizedBox(height: 10),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Submission logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Problem submitted successfully!')),
                        );
                      }
                    },
                    child: Text('Submit Problem'),
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
    _technologyRoleController.dispose();
    _surveyAnswersController.dispose();
    super.dispose();
  }
}
