import { useState, useEffect } from "react";
import { http_oracle_backend } from "declarations/http-oracle-backend";

function App() {
  const [priceData, setPriceData] = useState([]);
  const [fetching, setFetching] = useState(false);

  const fetchPriceData = async () => {
    setFetching(true);
    try {
      const rawData = await http_oracle_backend.get_icp_usd_exchange();
      const parsedData = JSON.parse(rawData);
      const formattedData = parsedData.map(([timestamp, , , , closePrice]) => ({
        timestamp,
        price: closePrice,
      }));
      setPriceData(formattedData);
    } catch (error) {
      console.error("Error fetching price data:", error);
    } finally {
      setFetching(false);
    }
  };

  useEffect(() => {
    fetchPriceData();
  }, []);

  return (
    <main>
      <header>
        <h1>BTC-USD Price Oracle</h1>
      </header>
      <section>
        <button onClick={fetchPriceData} disabled={fetching}>
          {fetching ? "Fetching..." : "Fetch Latest Price"}
        </button>
        <table>
          <thead>
            <tr>
              <th>Timestamp</th>
              <th>Price (USD)</th>
            </tr>
          </thead>
          <tbody>
            {priceData.map(({ timestamp, price }, index) => (
              <tr key={index}>
                <td>{new Date(Number(timestamp) * 1000).toLocaleString()}</td>
                <td>${price.toFixed(2)}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </section>
    </main>
  );
}

export default App;
