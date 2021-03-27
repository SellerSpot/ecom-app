import Head from 'next/head';
import styles from '../styles/App.module.scss';
import Home from '../components/Home/Home';

export default function App() {
    return (
        <div className={styles.appWrapper}>
            <Head>
                <title>SellerSpot Ecommerce</title>
                <link rel="icon" href="/favicon.ico" />
            </Head>
            <Home />
        </div>
    );
}
