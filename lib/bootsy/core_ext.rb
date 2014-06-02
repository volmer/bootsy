# Extend and include Bootsy in proper scopes.

ActionView::Base.send(:include, Bootsy::FormHelper)
ActionView::Helpers::FormBuilder.send(:include, Bootsy::FormBuilder)
