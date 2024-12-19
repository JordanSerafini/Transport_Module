import React, { useContext } from "react";
import GlobalContext from "../../../context/GlobalContext";

import NavMenu from "../../components/Menu/NavMenu";
import TransportPage from "../Transport/TransportPage";
import Dashboard from "../Dashboard/Dashboard";

const Home: React.FC = () => {
  const globalContext = useContext(GlobalContext);

  if (!globalContext) {
    throw new Error("GlobalContext must be used within a GlobalProvider");
  }

  const {  content, setContent } = globalContext;



  const handleUpdateContent = () => {
    setContent("Chantier");
  };

  const handleTransport = () => {
    setContent("Transport");
  }

  return (
    <div className="w-full h-full flex justify-start items-center ">
      <div className="">
        <NavMenu />
      </div>

      {content === "Home" && (
        <div className="w-full h-full justify-evenly flex">
          <button onClick={handleUpdateContent}>
            Page Chantier
          </button>
          <button onClick={handleTransport}>
            Page Transport
          </button>
        </div>
      )}
      {content === "Dashboard" && <Dashboard />}
      {content === "Transport" && <TransportPage/>}
    </div>
  );
};

export default Home;
