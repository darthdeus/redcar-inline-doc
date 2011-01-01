module Redcar
  class InlineDoc
   
    def self.keymaps
      linwin = Redcar::Keymap.build "main", [:linux, :windows] do
        link "Ctrl+Alt+Q", ShowDocumentationCommand
      end
      osx = Redcar::Keymap.build "main", :osx do
        link "Cmd+Alt+Q", ShowDocumentationCommand
      end          
      [linwin, osx]
    end            
    
    def self.menus
      Menu::Builder.build do
        sub_menu "Plugins" do
          sub_menu "Inline Documentation", :priority => 139 do
            item "Show!", ShowDocumentationCommand
          end
        end
      end
    end
    
    class ShowDocumentationCommand < Redcar::EditTabCommand
      
      # @todo Read current line and see if it is class method,
      # in which case invoke ri on the class
      def execute
        offset = doc.cursor_offset
        word = doc.word_at_offset(offset)
        Application::Dialog.popup_text(word, `ri -T -f simple #{word}`, :cursor)
      end
    end
    
  end
end