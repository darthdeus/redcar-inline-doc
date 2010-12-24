module Redcar
  class InlineDoc
   
    def self.keymaps
      linwin = Redcar::Keymap.build "main", [:linux, :windows] do
        link "Ctrl+Alt+L", ShowDocumentationCommand
      end
      osx = Redcar::Keymap.build "main", :osx do
        link "Cmd+Alt+L", ShowDocumentationCommand
      end      
      
      [linwin, osx]
    end            
    
        # This method is run as Redcar is booting up.
    def self.menus
      # Here's how the plugin menus are drawn. Try adding more
      # items or sub_menus.
      Menu::Builder.build do
        sub_menu "Plugins" do
          sub_menu "Inline Documentation", :priority => 139 do
            item "Show!", ShowDocumentationCommand
          end
        end
      end
    end
    
    class ShowDocumentationCommand < Redcar::EditTabCommand
      def execute
        offset = doc.cursor_offset
        word = doc.word_at_offset(offset)
        Application::Dialog.message_box("the word is '#{word}'")
      end
    end
    
  end
end