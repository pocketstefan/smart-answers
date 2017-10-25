module SmartAnswer
  class ExampleSmartAnswerFlow < Flow
    def define
      name 'example-smart-answer'

      value_question :question_1? do
        next_node do
          outcome :outcome_1
        end
      end

      outcome :outcome_1
    end
  end
end