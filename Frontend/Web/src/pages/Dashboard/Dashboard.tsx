import DriversList from "../../components/Dashboard/DriversList";
import ShipmentsList from "../../components/Dashboard/ShipmentsList";

function Dashboard() {
  return (
    <div className="bg-white-perso2 w-screen h-full p-8 text-gray-800 flex flex-col justify-between">

      <div className="rounded-3xl w-1/5 p-2 bg-white shadow-2xl">
        <DriversList />
      </div>

      <div className="w-full h-4.5/10">
        < ShipmentsList />
      </div>
    </div>
  );
}

export default Dashboard;
