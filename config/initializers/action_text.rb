# Be sure to restart your server when you modify this file.

# Whitelist attributes to use them in views/action_text.
# NOTE: According to the documentation, ActionText::ContentHelper.sanitizer_allowed_attributes
# whould be used to access the default values, but that doesn't work.
ActionText::ContentHelper.allowed_attributes = ActionText::ContentHelper.sanitizer.class.allowed_attributes + ['style', 'data-action', 'data-nowebpsrc', 'loading']
