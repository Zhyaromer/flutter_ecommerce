const express = require('express');
const app = express();
const PORT = 3000;
const path = require('path');
const cors = require('cors');
const authRoutes = require('./src/app/routes/auth');
const vendorRoutes = require('./src/app/routes/vendor');
const addressRoutes = require('./src/app/routes/address');

app.use(cors({
    origin: '*',
    credentials: true
}));

app.use(express.json());
app.use('/assets', express.static(path.join(__dirname, 'assets')));

app.use('/auth', authRoutes);
app.use('/vendor', vendorRoutes);
app.use('/address', addressRoutes);

//test route
app.get('/', (req, res) => {
    res.send('API is running...');
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
