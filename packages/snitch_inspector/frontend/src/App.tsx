import './App.css'
import {Button} from "@/components/ui/button.tsx";
import {DataTableDemo} from "@/components/logs/LogDatatable.tsx";

function App() {

  return (
      <>
          <div className="container mx-auto py-10">
              <DataTableDemo/>
          </div>
          <Button>Count</Button>
      </>
  )
}

export default App
